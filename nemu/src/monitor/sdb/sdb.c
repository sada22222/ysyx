/***************************************************************************************
* Copyright (c) 2014-2022 Zihao Yu, Nanjing University
*
* NEMU is licensed under Mulan PSL v2.
* You can use this software according to the terms and conditions of the Mulan PSL v2.
* You may obtain a copy of Mulan PSL v2 at:
*          http://license.coscl.org.cn/MulanPSL2
*
* THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
* EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
* MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
*
* See the Mulan PSL v2 for more details.
***************************************************************************************/

#include <isa.h>
#include <cpu/cpu.h>
#include <readline/readline.h>
#include <readline/history.h>
#include "sdb.h"

static int is_batch_mode = false;

void init_regex();
void init_wp_pool();
bool new_wp(char *args);
bool free_wp(int delNO);

void wp_display();
uint32_t paddr_read(paddr_t addr, int len);

static int cmd_help(char *args);
static int cmd_c(char *args);
static int cmd_q(char *args);
static int cmd_si(char *args);
static int cmd_info(char *args);
static int cmd_x(char *args);
static int cmd_p(char *args);
static int cmd_w(char *args);
static int cmd_d(char *args);
static int cmd_dis(char *args);

/* We use the `readline' library to provide more flexibility to read from stdin. */
static char* rl_gets() {
  static char *line_read = NULL;

  if (line_read) {
    free(line_read);
    line_read = NULL;
  }

  line_read = readline("(nemu) ");

  if (line_read && *line_read) {
    add_history(line_read);
  }

  return line_read;
}


static struct {
  const char *name;
  const char *description;
  int (*handler) (char *);
} cmd_table [] = {
  { "help", "Display information about all supported commands", cmd_help },
  { "c", "Continue the execution of the program", cmd_c },
  { "q", "Exit NEMU", cmd_q },
 
  /* TODO: Add more commands */
  { "si", "Step execute N instructions", cmd_si },  
  { "info", "Print information", cmd_info }, 
  { "x", "Examine memory", cmd_x },  
  { "p", "Calculate the value of a regular expression", cmd_p},
  { "w", "Create a new watch point with the expression", cmd_w},
  { "d", "Delete a watch point from link list.", cmd_d},  
  { "display", "Display all watch point from link list.", cmd_dis}, 

};

#define NR_CMD ARRLEN(cmd_table)

static int cmd_help(char *args) {
  /* extract the first argument */
  char *arg = strtok(NULL, " ");
  int i;

  if (arg == NULL) {
    /* no argument given */
    for (i = 0; i < NR_CMD; i ++) {
      printf("%s - %s\n", cmd_table[i].name, cmd_table[i].description);
    }
  }
  else {
    for (i = 0; i < NR_CMD; i ++) {
      if (strcmp(arg, cmd_table[i].name) == 0) {
        printf("%s - %s\n", cmd_table[i].name, cmd_table[i].description);
        return 0;
      }
    }
    printf("Unknown command '%s'\n", arg);
  }
  return 0;
}

static int cmd_c(char *args) {
  cpu_exec(-1);
  return 0;
}


static int cmd_q(char *args) {
  return -1;
}

static int cmd_si(char *args) {
  int N = 1;  

  if (args != NULL) {
    sscanf(args, "%d", &N);  // 将字符串转换为整数
  }

  cpu_exec(N);  

  printf("Step executed: N=%d\n", N);  
  return 0;
}

static int cmd_info(char *args) {
  if (args == NULL) {
    printf("Usage: info r or w\n");
    return 0;
  }
  if (strcmp(args, "r") == 0) {
    isa_reg_display();
  }else if(strcmp(args, "w") == 0){
  if (head == NULL) {
    printf("There are no watch points.\n");
  } else {
    wp_display();  // 显示所有监视点
  }
 }
  else {
    printf("Unknown argument for info: %s\n", args);
  }
  return 0;
}

static int cmd_x(char *args) {
  char *argN = strtok(args, " ");
  char *argEXPR = strtok(NULL, " ");

  if (argN == NULL || argEXPR == NULL) {
    printf("Usage: x <N> <EXPR>\n");
    return 0;
  }

  char *ptrN = NULL;
  char *ptrEXPR = NULL;
  uint32_t N = strtoul(argN, &ptrN, 10); 
  uint32_t EXPR = strtoul(argEXPR, &ptrEXPR, 16); 

  if (((argN + strlen(argN)) != ptrN) || ((argEXPR + strlen(argEXPR)) != ptrEXPR)) {
    printf("Check your input cmd, args can not contain non-numeric letters!\n");
    return 0;
  }

  for (int i = 0; i < N; i++) {
    uint32_t paddr = EXPR + i * 4;  // 这里假设按4字节读取
    printf("0x%08x:\t0x%08x\n", paddr, paddr_read(paddr, 4));
  }
  
  return 0;
}

static int cmd_p(char *args) {
  bool success;
  uint32_t EXPR;
  EXPR = expr(args, &success);
  if(success){
    printf("input expression == %d\n",EXPR);
  }
  else{
    printf("Error!Check your inpur expression!!\n");
  }
  return 0;
}

static int cmd_w(char *args) {
  if(!new_wp(args)){
    printf("fail to add watch point.check your watch point expression.");
  }
  return 0;
}

static int cmd_d(char *args) {
  if(!free_wp(strtoul(args,NULL,10))){
    printf("del wp failure\n");
  }
  return 0;
}

static int cmd_dis(char *args) {
  // 检查是否有任何活动的监视点
  if (head == NULL) {
    printf("There are no watch points.\n");
  } else {
    wp_display();  // 显示所有监视点
  }
  return 0;
}

void sdb_set_batch_mode() {
  is_batch_mode = true;
}

void sdb_mainloop() {
  if (is_batch_mode) {
    cmd_c(NULL);
    return;
  }

  for (char *str; (str = rl_gets()) != NULL; ) {
    char *str_end = str + strlen(str);

    /* extract the first token as the command */
    char *cmd = strtok(str, " ");
    if (cmd == NULL) { continue; }

    /* treat the remaining string as the arguments,
     * which may need further parsing
     */
    char *args = cmd + strlen(cmd) + 1;
    if (args >= str_end) {
      args = NULL;
    }

#ifdef CONFIG_DEVICE
    extern void sdl_clear_event_queue();
    sdl_clear_event_queue();
#endif

    int i;
    for (i = 0; i < NR_CMD; i ++) {
      if (strcmp(cmd, cmd_table[i].name) == 0) {
        if (cmd_table[i].handler(args) < 0) { return; }
        break;
      }
    }

    if (i == NR_CMD) { printf("Unknown command '%s'\n", cmd); }
  }
}

void init_sdb() {
  /* Compile the regular expressions. */
  init_regex();

  /* Initialize the watchpoint pool. */
  init_wp_pool();
}

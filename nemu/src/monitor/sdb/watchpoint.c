

#include "sdb.h"

#define NR_WP 32

WP wp_pool[NR_WP] = {};
WP *head = NULL;
WP *free_ = NULL;

void init_wp_pool() {
  int i;
  for (i = 0; i < NR_WP; i ++) {
    wp_pool[i].NO = i + 1;  // Watchpoint numbers start from 1
    wp_pool[i].next = (i == NR_WP - 1 ? NULL : &wp_pool[i + 1]);
  }

  head = NULL;
  free_ = wp_pool;
}

WP* new_wp(char *args) {
  // Allocate a new watchpoint from the free list
  if (free_ == NULL) {
    printf("No more watchpoints available.\n");
    return NULL;
  }

  WP *newwp = free_;
  free_ = free_->next;

  bool success;
  strncpy(newwp->expr, args, sizeof(newwp->expr) - 1);
  newwp->expr[sizeof(newwp->expr) - 1] = '\0';  // Ensure null-termination
  newwp->oldval = 0;
  newwp->newval = expr(newwp->expr, &success);
  newwp->next = NULL;

  if (!success) {
    printf("Expression evaluation failed.\n");
    newwp->next = free_;
    free_ = newwp;
    return NULL;
  }

  // Insert the new watchpoint into the active list
  if (head == NULL) {
    head = newwp;
  } else {
    WP *p;
    for (p = head; p->next != NULL; p = p->next);
    p->next = newwp;
  }

  printf("New watchpoint %d: expr = %s, value = 0x%x\n", newwp->NO, newwp->expr, newwp->newval);
  return newwp;
}

bool free_wp(int delNO) {
  WP *prev = NULL;
  WP *p = head;

  // Locate the watchpoint with the given number
  while (p != NULL && p->NO != delNO) {
    prev = p;
    p = p->next;
  }

  if (p == NULL) {
    printf("Watchpoint %d not found.\n", delNO);
    return false;
  }

  // Remove the watchpoint from the active list
  if (prev == NULL) {
    head = p->next;
  } else {
    prev->next = p->next;
  }

  // Return the watchpoint to the free list
  p->next = free_;
  free_ = p;

  printf("Removed watchpoint %d: expr = %s, value = 0x%x\n", delNO, p->expr, p->newval);
  return true;
}

bool WP_check_update() {
  WP *p = head;
  bool success;
  bool update = false;

  while (p != NULL) {
    p->oldval = p->newval;
    p->newval = expr(p->expr, &success);

    if (p->oldval != p->newval) {
      update = true;
      printf("Watchpoint %d triggered: expr = %s, old value = 0x%x, new value = 0x%x\n",
             p->NO, p->expr, p->oldval, p->newval);
    }
    p = p->next;
  }

  return update;
}

void wp_display() {
  WP *p = head;
  while (p != NULL) {
    printf("Watchpoint %d: expr = %s, old value = 0x%x, new value = 0x%x\n",
           p->NO, p->expr, p->oldval, p->newval);
    p = p->next;
  }
}

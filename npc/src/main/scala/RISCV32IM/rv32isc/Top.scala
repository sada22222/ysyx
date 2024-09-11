package rv32isc


import chisel3._
import chisel3.util._

import config.Configs._

class top extends Module {
    val io=IO(new Bundle() {
        val instr_req_o = Output(Bool())
        val instr_gnt_i = Input(Bool())
        val instr_rvalid_i = Input(Bool())
        val instr_addr_o = Output(UInt(32.W))
        val instr_rdata_i = Input(UInt(32.W))
        val instr_err_i = Input(Bool())

        //OUTPUT to outside
        val mem_access_misaligned_o = Output(Bool())
        val mem_stall_o = Output(Bool())
        val mem_addr_o = Output(UInt(32.W))
        val mem_mem_we_o = Output(Bool())
        val mem_be_o = Output(UInt(4.W))
        val mem_req_o = Output(Bool())

        val int_req_i=Input(Bool())
        val int_id_i=Input(UInt(7.W))

        //from rom
        val mem_rdata_i=Input(UInt(32.W))
        val mem_gnt_i=Input(Bool())
        val mem_rvalid_i=Input(Bool())
    })

    val fetch   = Module(new IFU)
    val if_id    = Module(new IF_ID)
    val id = Module(new ID)
    val id_ex    = Module(new ID_EX)
    val ex     = Module(new EX)
    val ex_mem   = Module(new EX_MEM)
    val mem     = Module(new MEM)
    val mem_wb   = Module(new MEM_WB)
    val wb      = Module(new WB)
    val regfile =Module(new Registers)
    val Ctrl =Module(new PipeCtrl)
    val csr_reg = Module(new CSRReg)
    val exception= Module(new Exception)

    fetch.io.ifu<>if_id.io.if_i
    if_id.io.id_o<>id.io.if_i
    id.io.idu_o<>id_ex.io.id_i
    id_ex.io.ex_o<>ex.io.id_i
    ex.io.ex_o<>ex_mem.io.ex_i
    ex_mem.io.mem_o<>mem.io.ex_i
    mem.io.mem_o<>mem_wb.io.mem_i
    mem_wb.io.wb_o<>wb.io.wb_i

    regfile.io.wen:=wb.io.reg_we_o
    regfile.io.waddr:=wb.io.reg_waddr_o
    regfile.io.wdata:=wb.io.reg_wdata_o
    regfile.io.rdaddr1_i:=id.io.rs1_raddr
    regfile.io.rdaddr2_i:=id.io.rs2_raddr
    id.io.reg1_rdata_i:=regfile.io.rdata1_o
    id.io.reg2_rdata_i:=regfile.io.rdata2_o   

    id.io.inst_ex:=id_ex.io.ex_o.inst
    id.io.rd_ex:=id_ex.io.ex_o.rd_waddr
    id.io.access_rd_ex:=id_ex.io.ex_o.rd_we
    id.io.inst_mem:=ex_mem.io.mem_o.inst
    id.io.rd_mem:=ex_mem.io.mem_o.rd_waddr
    id.io.access_rd_mem:=ex_mem.io.mem_o.rd_we

    ex.io.last_rs1_rd:=id.io.last_rs1_rd
    ex.io.last_rs2_rd:=id.io.last_rs2_rd
    ex.io.last_two_rs1_rd:=id.io.last_two_rs1_rd
    ex.io.last_two_rs2_rd:=id.io.last_two_rs2_rd
    ex.io.mem_alu_res:=mem.io.mem_o.alu_res
    ex.io.mem_pc:=ex_mem.io.mem_o.bjp_res
    ex.io.wb_alu_res:=mem_wb.io.wb_o.alu_res
    ex.io.wb_pc:=mem_wb.io.wb_o.bjp_res
    

    fetch.io.flush_i:=Ctrl.io.flush_IF_ID
    if_id.io.flush_i:=Ctrl.io.flush_IF_ID
    id_ex.io.flush_i:=Ctrl.io.flush_IF_ID

    Ctrl.io.stall_from_if_i:=fetch.io.stall_i
    Ctrl.io.stall_from_id_i:=id.io.stall_o
    Ctrl.io.stall_from_ex_i:=ex.io.hold_flag_o||exception.io.stall_flag_o
    Ctrl.io.stall_from_mem_i:=mem.io.mem_stall_o
    Ctrl.io.int_addr_i:=exception.io.int_addr_o
    Ctrl.io.int_assert_i:=exception.io.int_assert_o

    exception.io.illegal_inst_i:=id.io.illegal_inst_o
    exception.io.inst_valid_i:=id.io.idu_o.inst_valid
   // exception.io.inst_executed_i:=id.io.ex_inst_executed_o
    exception.io.inst_ecall_i:=ex.io.inst_ecall_o
    exception.io.inst_ebreak_i:=ex.io.inst_ebreak_o
    exception.io.inst_mret_i:=ex.io.inst_mret_o
    exception.io.inst_dret_i:=ex.io.inst_dret_o
    exception.io.mtvec_i:=csr_reg.io.mtvec_o
    exception.io.mepc_i:=csr_reg.io.mepc_o
    exception.io.mstatus_i:=csr_reg.io.mstatus_o
    exception.io.mie_i:=csr_reg.io.mie_o
    exception.io.dpc_i:=csr_reg.io.dpc_o
    exception.io.dcsr_i:=csr_reg.io.dcsr_o
    exception.io.trigger_match_i:=csr_reg.io.trigger_match_o
    ex.io.int_stall_i:=exception.io.stall_flag_o
    exception.io.int_req_i:=io.int_req_i
    exception.io.int_id_i:=io.int_id_i


    csr_reg.io.excep_we_i:=exception.io.csr_we_o
    csr_reg.io.excep_waddr_i:=exception.io.csr_waddr_o
    csr_reg.io.excep_wdata_i:=exception.io.csr_wdata_o


}
object top extends App {
  chisel3.Driver.execute(args, () => new top)
}


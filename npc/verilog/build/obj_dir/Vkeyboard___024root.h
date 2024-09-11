// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vkeyboard.h for the primary calling header

#ifndef VERILATED_VKEYBOARD___024ROOT_H_
#define VERILATED_VKEYBOARD___024ROOT_H_  // guard

#include "verilated.h"

class Vkeyboard__Syms;

class Vkeyboard___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    VL_IN8(clock,0,0);
    VL_IN8(reset,0,0);
    VL_IN8(io_ps2_clk,0,0);
    VL_IN8(io_ps2_data,0,0);
    VL_OUT8(io_seg_0,7,0);
    VL_OUT8(io_seg_1,7,0);
    VL_OUT8(io_seg_2,7,0);
    VL_OUT8(io_seg_3,7,0);
    VL_OUT8(io_seg_4,7,0);
    VL_OUT8(io_seg_5,7,0);
    VL_OUT8(io_seg_6,7,0);
    VL_OUT8(io_seg_7,7,0);
    CData/*1:0*/ keyboard__DOT__state;
    CData/*7:0*/ keyboard__DOT__lastKeyCode;
    CData/*7:0*/ keyboard__DOT__keyCount;
    CData/*0:0*/ keyboard__DOT__newKeyPress;
    CData/*0:0*/ keyboard__DOT__fifo_clean;
    CData/*0:0*/ keyboard__DOT___T;
    CData/*0:0*/ keyboard__DOT___T_1;
    CData/*7:0*/ keyboard__DOT___T_3;
    CData/*0:0*/ keyboard__DOT___T_4;
    CData/*0:0*/ keyboard__DOT___GEN_6;
    CData/*0:0*/ keyboard__DOT___GEN_12;
    CData/*7:0*/ keyboard__DOT__ps2Keyboard__DOT__fifo_0;
    CData/*2:0*/ keyboard__DOT__ps2Keyboard__DOT__w_ptr;
    CData/*3:0*/ keyboard__DOT__ps2Keyboard__DOT__count;
    CData/*0:0*/ keyboard__DOT__ps2Keyboard__DOT__ps2_clk_sync_1;
    CData/*0:0*/ keyboard__DOT__ps2Keyboard__DOT__ps2_clk_sync_2;
    CData/*0:0*/ keyboard__DOT__ps2Keyboard__DOT__sampling;
    CData/*0:0*/ keyboard__DOT__ps2Keyboard__DOT__ready;
    CData/*0:0*/ keyboard__DOT__ps2Keyboard__DOT___T_3;
    CData/*0:0*/ keyboard__DOT__ps2Keyboard__DOT___T_9;
    CData/*2:0*/ keyboard__DOT__ps2Keyboard__DOT___T_12;
    CData/*0:0*/ keyboard__DOT__ps2Keyboard__DOT___GEN_29;
    CData/*3:0*/ keyboard__DOT__ps2Keyboard__DOT___T_24;
    CData/*0:0*/ __Vtrigrprev__TOP__clock;
    CData/*0:0*/ __VactContinue;
    SData/*9:0*/ keyboard__DOT__ps2Keyboard__DOT__buffer;
    SData/*15:0*/ keyboard__DOT__ps2Keyboard__DOT___GEN_55;
    IData/*31:0*/ __VstlIterCount;
    IData/*31:0*/ __VicoIterCount;
    IData/*31:0*/ __VactIterCount;
    VlTriggerVec<1> __VstlTriggered;
    VlTriggerVec<1> __VicoTriggered;
    VlTriggerVec<1> __VactTriggered;
    VlTriggerVec<1> __VnbaTriggered;

    // INTERNAL VARIABLES
    Vkeyboard__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vkeyboard___024root(Vkeyboard__Syms* symsp, const char* v__name);
    ~Vkeyboard___024root();
    VL_UNCOPYABLE(Vkeyboard___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);


#endif  // guard

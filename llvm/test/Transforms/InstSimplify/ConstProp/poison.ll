; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instsimplify -S | FileCheck %s

declare void @use(...)

define void @casts() {
; CHECK-LABEL: @casts(
; CHECK-NEXT:    call void (...) @use(i8 poison, i8 poison, i8 poison, i8 poison, i8 poison, i32 poison, i8 poison, float poison, float poison, float poison, float poison)
; CHECK-NEXT:    ret void
;
  %i1 = trunc i32 poison to i8
  %i2 = zext i4 poison to i8
  %i3 = sext i4 poison to i8
  %i4 = fptoui float poison to i8
  %i5 = fptosi float poison to i8
  %i6 = bitcast float poison to i32
  %i7 = ptrtoint i8* poison to i8
  %f1 = fptrunc double poison to float
  %f2 = fpext half poison to float
  %f3 = uitofp i8 poison to float
  %f4 = sitofp i8 poison to float
  call void (...) @use(i8 %i1, i8 %i2, i8 %i3, i8 %i4, i8 %i5, i32 %i6, i8 %i7, float %f1, float %f2, float %f3, float %f4)
  ret void
}

define void @casts2() {
; CHECK-LABEL: @casts2(
; CHECK-NEXT:    call void (...) @use(i8* poison, i8* poison)
; CHECK-NEXT:    ret void
;
  %p1 = inttoptr i8 poison to i8*
  %p2 = addrspacecast i8 addrspace(1)* poison to i8*
  call void (...) @use(i8* %p1, i8* %p2)
  ret void
}

define void @unaryops() {
; CHECK-LABEL: @unaryops(
; CHECK-NEXT:    call void (...) @use(float poison)
; CHECK-NEXT:    ret void
;
  %f1 = fneg float poison
  call void (...) @use(float %f1)
  ret void
}

define void @binaryops_arith() {
; CHECK-LABEL: @binaryops_arith(
; CHECK-NEXT:    call void (...) @use(i8 poison, i8 poison, i8 poison, i8 poison, i8 poison, i8 poison, i8 poison, i8 poison, i8 poison, i8 poison, i8 poison, float poison, float poison, float poison, float poison, float poison, float poison, float poison)
; CHECK-NEXT:    ret void
;
  %i1 = add i8 poison, 1
  %i2 = sub i8 poison, 1
  %i3 = mul i8 poison, 2
  %i4 = udiv i8 poison, 2
  %i5 = udiv i8 2, poison
  %i6 = sdiv i8 poison, 2
  %i7 = sdiv i8 2, poison
  %i8 = urem i8 poison, 2
  %i9 = urem i8 2, poison
  %i10 = srem i8 poison, 2
  %i11 = srem i8 2, poison
  %f1 = fadd float poison, 1.0
  %f2 = fsub float poison, 1.0
  %f3 = fmul float poison, 2.0
  %f4 = fdiv float poison, 2.0
  %f5 = fdiv float 2.0, poison
  %f6 = frem float poison, 2.0
  %f7 = frem float 2.0, poison
  call void (...) @use(i8 %i1, i8 %i2, i8 %i3, i8 %i4, i8 %i5, i8 %i6, i8 %i7, i8 %i8, i8 %i9, i8 %i10, i8 %i11, float %f1, float %f2, float %f3, float %f4, float %f5, float %f6, float %f7)
  ret void
}

define void @binaryops_bitwise() {
; CHECK-LABEL: @binaryops_bitwise(
; CHECK-NEXT:    call void (...) @use(i8 poison, i8 poison, i8 poison, i8 poison, i8 poison, i8 poison, i8 poison, i8 poison, i8 poison)
; CHECK-NEXT:    ret void
;
  %i1 = shl i8 poison, 1
  %i2 = shl i8 1, poison
  %i3 = lshr i8 poison, 1
  %i4 = lshr i8 1, poison
  %i5 = ashr i8 poison, 1
  %i6 = ashr i8 1, poison
  %i7 = and i8 poison, 1
  %i8 = or i8 poison, 1
  %i9 = xor i8 poison, 1
  call void (...) @use(i8 %i1, i8 %i2, i8 %i3, i8 %i4, i8 %i5, i8 %i6, i8 %i7, i8 %i8, i8 %i9)
  ret void
}

define void @vec_aggr_ops() {
; CHECK-LABEL: @vec_aggr_ops(
; CHECK-NEXT:    call void (...) @use(i8 poison, i8 poison, <2 x i8> poison, i8 poison)
; CHECK-NEXT:    ret void
;
  %i1 = extractelement <2 x i8> poison, i64 0
  %i2 = extractelement <2 x i8> zeroinitializer, i64 poison
  %i3 = insertelement <2 x i8> zeroinitializer, i8 0, i64 poison
  %i4 = extractvalue {i8, i8} poison, 0
  call void (...) @use(i8 %i1, i8 %i2, <2 x i8> %i3, i8 %i4)
  ret void
}

define void @other_ops(i8 %x) {
; CHECK-LABEL: @other_ops(
; CHECK-NEXT:    call void (...) @use(i1 poison, i1 poison, i8 poison, i8 poison, i8* poison, i8* poison)
; CHECK-NEXT:    ret void
;
  %i1 = icmp eq i8 poison, 1
  %i2 = fcmp oeq float poison, 1.0
  %i3 = select i1 poison, i8 1, i8 2
  %i4 = select i1 true, i8 poison, i8 %x
  call void (...) @use(i1 %i1, i1 %i2, i8 %i3, i8 %i4, i8* getelementptr (i8, i8* poison, i64 1), i8* getelementptr inbounds (i8, i8* undef, i64 1))
  ret void
}

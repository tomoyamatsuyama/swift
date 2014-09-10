// RUN: %swift -emit-silgen %s | FileCheck %s

struct Foo {}
class Bar {}

// CHECK: [[CONCRETE:%.*]] = init_existential [[EXISTENTIAL:%.*]] : $*protocol<>, $Foo.Type
// CHECK: [[METATYPE:%.*]] = metatype $@thick Foo.Type
// CHECK: store [[METATYPE]] to [[CONCRETE]] : $*@thick Foo.Type
let x: Any = Foo.self


// CHECK: [[CONCRETE:%.*]] = init_existential [[EXISTENTIAL:%.*]] : $*protocol<>, $() -> () // user: %11
// CHECK: [[CLOSURE:%.*]] = function_ref
// CHECK: [[CLOSURE_THICK:%.*]] = thin_to_thick_function [[CLOSURE]]
// CHECK: [[REABSTRACTION_THUNK:%.*]] = function_ref @_TTRXFo__dT__XFo_iT__iT__
// CHECK: [[CLOSURE_REABSTRACTED:%.*]] = partial_apply [[REABSTRACTION_THUNK]]([[CLOSURE_THICK]])
// CHECK: store [[CLOSURE_REABSTRACTED]] to [[CONCRETE]]
let y: Any = {() -> () in ()}


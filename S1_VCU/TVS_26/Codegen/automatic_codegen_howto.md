# Code Generation Setup
## MATLAB Version
The code generation must be run in r2024a, newer versions produce different output

# Manual Generation
1. Add `Controllers` folder to path
2. Run `VCU_MAIN` from the `Codegen` folder
3. Follow instructions in `manual_code_generation_how_to.docx` to generate c code
4. Copy `vcu_step.c` from the `codegen/lib/vcu_step` folder, `vcu_init.c`, `vcu.h` from the `BUILD_OUTPUT` folder to `source/torque_vector/vcu/` in the firmware repository.

# Automatic Generation
1. Run `BUILD.m`
2. Copy `vcu_step.c`, `vcu_init.c`, `vcu.h` from the `BUILD_OUTPUT` folder to `source/torque_vector/vcu/` in the firmware repository.

# Post-processing (both methods)
1. The headers on `vcu_step` should originally be
```
#include "vcu_step.h"
#include "vcu_step_types.h"
#include <math.h>
```
2. Replace these with
```
#include <math.h>
#include "vcu.h"
```
3. Add ` #include "vcu.h" ` to the top of `vcu_init.c`

4. Add the following to the bottom `vcu.h`
```
xVCU_struct init_xVCU(void);
yVCU_struct init_yVCU(void);
pVCU_struct init_pVCU(void);
```

5. Add the following somewhere in `main.c`
```
static pVCU_struct pVCU;
static xVCU_struct xVCU;
static yVCU_struct yVCU;
```

6. Call the init functions in `int main(void)`
```
pVCU = init_pVCU();
xVCU = init_xVCU();
yVCU = init_yVCU();
```

7. Add `#include "vcu.h"` to `main.h` and `vcu_init.c`

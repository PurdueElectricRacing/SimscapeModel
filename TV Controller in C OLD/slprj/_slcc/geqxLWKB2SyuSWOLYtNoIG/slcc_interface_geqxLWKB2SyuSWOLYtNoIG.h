#include "customcode_geqxLWKB2SyuSWOLYtNoIG.h"
#ifdef __cplusplus
extern "C" {
#endif


/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */
DLL_EXPORT_CC extern const char_T *get_dll_checksum_geqxLWKB2SyuSWOLYtNoIG(void);
DLL_EXPORT_CC extern void print_tableau_geqxLWKB2SyuSWOLYtNoIG(Tableau *tab, const char_T *mes);
DLL_EXPORT_CC extern void nl_geqxLWKB2SyuSWOLYtNoIG(int32_T k);
DLL_EXPORT_CC extern void pivot_on_geqxLWKB2SyuSWOLYtNoIG(Tableau *tab, int32_T row, int32_T col);
DLL_EXPORT_CC extern int32_T find_pivot_column_geqxLWKB2SyuSWOLYtNoIG(Tableau *tab);
DLL_EXPORT_CC extern int32_T find_pivot_row_geqxLWKB2SyuSWOLYtNoIG(Tableau *tab, int32_T pivot_col);
DLL_EXPORT_CC extern void add_slack_variables_geqxLWKB2SyuSWOLYtNoIG(Tableau *tab);
DLL_EXPORT_CC extern void check_b_positive_geqxLWKB2SyuSWOLYtNoIG(Tableau *tab);
DLL_EXPORT_CC extern int32_T find_basis_variable_geqxLWKB2SyuSWOLYtNoIG(Tableau *tab, int32_T col);
DLL_EXPORT_CC extern void print_optimal_vector_geqxLWKB2SyuSWOLYtNoIG(Tableau *tab, real32_T *T1, real32_T *T2, real32_T *T3, real32_T *T4);
DLL_EXPORT_CC extern int32_T simplex_geqxLWKB2SyuSWOLYtNoIG(Tableau *tab, real32_T *T1, real32_T *T2, real32_T *T3, real32_T *T4);
DLL_EXPORT_CC extern int32_T bigM_func_geqxLWKB2SyuSWOLYtNoIG(real32_T T2F_1, real32_T T2F_2, real32_T T2F_3, real32_T T2F_4, real32_T b, real32_T A_1, real32_T A_2, real32_T A_3, real32_T A_4, real32_T beq, real32_T Aeq_1, real32_T Aeq_2, real32_T Aeq_3, real32_T Aeq_4, real32_T lb_1, real32_T lb_2, real32_T lb_3, real32_T lb_4, real32_T ub_1, real32_T ub_2, real32_T ub_3, real32_T ub_4, real32_T *T1, real32_T *T2, real32_T *T3, real32_T *T4, int32_T T1_sign, int32_T T2_sign, int32_T T3_sign, int32_T T4_sign, real32_T yaw_err_limit);

/* Function Definitions */
DLL_EXPORT_CC const uint8_T *get_checksum_source_info(int32_T *size);
#ifdef __cplusplus
}
#endif


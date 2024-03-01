#include "customcode_uDnR86VCncfK3wK0QEehBD.h"
#ifdef __cplusplus
extern "C" {
#endif


/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */
DLL_EXPORT_CC extern const char_T *get_dll_checksum_uDnR86VCncfK3wK0QEehBD(void);
DLL_EXPORT_CC extern void pivot_on_uDnR86VCncfK3wK0QEehBD(Tableau *tab, int32_T row, int32_T col);
DLL_EXPORT_CC extern int32_T find_pivot_column_uDnR86VCncfK3wK0QEehBD(Tableau *tab);
DLL_EXPORT_CC extern int32_T find_pivot_row_uDnR86VCncfK3wK0QEehBD(Tableau *tab, int32_T pivot_col);
DLL_EXPORT_CC extern void add_slack_variables_uDnR86VCncfK3wK0QEehBD(Tableau *tab);
DLL_EXPORT_CC extern void check_b_positive_uDnR86VCncfK3wK0QEehBD(Tableau *tab);
DLL_EXPORT_CC extern int32_T find_basis_variable_uDnR86VCncfK3wK0QEehBD(Tableau *tab, int32_T col);
DLL_EXPORT_CC extern void print_optimal_vector_uDnR86VCncfK3wK0QEehBD(Tableau *tab, real_T *T1, real_T *T2, real_T *T3, real_T *T4);
DLL_EXPORT_CC extern int32_T simplex_uDnR86VCncfK3wK0QEehBD(Tableau *tab, real_T *T1, real_T *T2, real_T *T3, real_T *T4);
DLL_EXPORT_CC extern int32_T bigM_func_uDnR86VCncfK3wK0QEehBD(real_T T2F_1, real_T T2F_2, real_T T2F_3, real_T T2F_4, real_T b, real_T A_1, real_T A_2, real_T A_3, real_T A_4, real_T beq, real_T Aeq_1, real_T Aeq_2, real_T Aeq_3, real_T Aeq_4, real_T lb_1, real_T lb_2, real_T lb_3, real_T lb_4, real_T ub_1, real_T ub_2, real_T ub_3, real_T ub_4, real_T *T1, real_T *T2, real_T *T3, real_T *T4, real_T yaw_err_limit);

/* Function Definitions */
DLL_EXPORT_CC const uint8_T *get_checksum_source_info(int32_T *size);
#ifdef __cplusplus
}
#endif


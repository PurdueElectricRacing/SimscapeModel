#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<stdbool.h>

#define MAXCHAR 1000

#include <math.h>
#include <assert.h>

#define M 25
#define N 25
#define bM 10000000

typedef struct {
  int m, n; // m=rows, n=columns, mat[m x n]
  double mat[M][N];
} Tableau;

void print_tableau(Tableau *tab, const char* mes);
void nl(int k);
void pivot_on(Tableau *tab, int row, int col);
int find_pivot_column(Tableau *tab);
int find_pivot_row(Tableau *tab, int pivot_col);
void add_slack_variables(Tableau *tab);
void check_b_positive(Tableau *tab);
int find_basis_variable(Tableau *tab, int col);
void print_optimal_vector(Tableau *tab, float* T1, float* T2, float* T3, float* T4);
int simplex(Tableau *tab, float* T1, float* T2, float* T3, float* T4);
int bigM_func(float T2F_1, float T2F_2, float T2F_3, float T2F_4, 
  float b, 
  float A_1, float A_2, float A_3, float A_4, 
  float beq, float Aeq_1, float Aeq_2, float Aeq_3, float Aeq_4,
  float lb_1, float lb_2, float lb_3, float lb_4,
  float ub_1, float ub_2, float ub_3, float ub_4,
  float* T1, float* T2, float* T3, float* T4,
  int T1_sign, int T2_sign, int T3_sign, int T4_sign,
  float yaw_err_limit); // if Tx is negative, then negate it and treat it as positive
//int check_constraint(float* simu, float T1, float T2, float T3, float T4, float err, FILE* csv);
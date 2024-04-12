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

void pivot_on(Tableau *tab, int row, int col);
int find_pivot_column(Tableau *tab);
int find_pivot_row(Tableau *tab, int pivot_col);
void add_slack_variables(Tableau *tab);
void check_b_positive(Tableau *tab);
int find_basis_variable(Tableau *tab, int col);
void print_optimal_vector(Tableau *tab, double* T1, double* T2, double* T3, double* T4);
int simplex(Tableau *tab, double* T1, double* T2, double* T3, double* T4);
int bigM_func(double T2F_1, double T2F_2, double T2F_3, double T2F_4, double b, 
  double A_1, double A_2, double A_3, double A_4, double beq, double Aeq_1, 
  double Aeq_2, double Aeq_3, double Aeq_4, double lb_1, double lb_2, double lb_3,
  double lb_4, double ub_1, double ub_2, double ub_3, double ub_4, double* T1, double* T2,
  double* T3, double* T4, double yaw_err_limit);
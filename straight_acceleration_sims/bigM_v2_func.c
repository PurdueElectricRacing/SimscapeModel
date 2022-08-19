// full input data set (Feb_7) for Simplex iteration statistics

// modifications over v1: suppress error for negative first column value
//                        input data set changed (to a better accuracy one)
//                        log output to csv file
//                        adapt code structure to be able to be called from Simulink
#include "bigM_v2_func.h"

static const double epsilon   = 1.0e-8;
int equal(double a, double b) { return fabs(a-b) < epsilon; }

// typedef struct {
//   int m, n; // m=rows, n=columns, mat[m x n]
//   double mat[M][N];
// } Tableau;

// return: flag
//         -1 = default, 0 = infeasible (not mathematically), 1 = too many iterations (20)
//          2 = unbounded (no pivot row), 3 = optimal solution within yaw_err_limit
int bigM_func(float T2F_1, float T2F_2, float T2F_3, float T2F_4, 
  float b, 
  float A_1, float A_2, float A_3, float A_4, 
  float beq, float Aeq_1, float Aeq_2, float Aeq_3, float Aeq_4,
  float lb_1, float lb_2, float lb_3, float lb_4,
  float ub_1, float ub_2, float ub_3, float ub_4,
  float* T1, float* T2, float* T3, float* T4,
  int T1_sign, int T2_sign, int T3_sign, int T4_sign,
  float yaw_err_limit) // if Tx is negative, then negate it and treat it as positive
                       // set the limit for yaw error when the flag has to return as fail
{ // Tx_sign = -1 when negative, = 1 when positive

  int flag = 0; // flag for Simplex
  float yaw_err;

  int torque_sign[4] = {T1_sign, T2_sign, T3_sign, T4_sign};


  // default all positive form of Tableau (1s and -1s are just for positional reference)

  //int* tab_inq = {0, 1, 0, -1, -1, -1, -1, 1, 1, 1, 1}; // sign for each row
                                                        // 0  = equal
                                                        // 1  = constant larger than polynomial
                                                        // -1 = constant smaller than polynomial 

  Tableau tab = {11, 24, {
    {0,     -T2F_1, -T2F_2, -T2F_3, -T2F_4, 0, 0, 0, 0, 0, 0, 0, 0, 0, bM, bM, bM, bM, bM, 0, 0, 0, 0, 1, },
    {b, A_1, A_2, A_3, A_4, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
    {beq, Aeq_1, Aeq_2, Aeq_3, Aeq_4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
    {lb_1,  1, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, },
    {lb_2,  0, 1, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, },
    {lb_3,  0, 0, 1, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, },
    {lb_4,  0, 0, 0, 1, 0, 0, 0,  0,-1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, },
    {ub_1,  1, 0, 0, 0, 0, 0, 0,  0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
    {ub_2,  0, 1, 0, 0, 0, 0, 0,  0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
    {ub_3,  0, 0, 1, 0, 0, 0, 0,  0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
    {ub_4,  0, 0, 0, 1, 0, 0, 0,  0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, },
  }};

  print_tableau(&tab,"Original input with default Tableau");
  // calculate negative torque as positive (and turn them back later)
  //   modify the constraint equations
  for(int i = 0; i < 4; i++) {
    if(torque_sign[i] == -1){
      tab.mat[0][i+1] = - tab.mat[0][i+1]; // objective function 
      tab.mat[1][i+1] = - tab.mat[1][i+1]; // power limit inq
      tab.mat[2][i+1] = - tab.mat[2][i+1]; // yaw equality
      tab.mat[i+3][i+1] = - tab.mat[i+3][i+1]; // lb (don't change lb_x)
      tab.mat[i+7][i+1] = - tab.mat[i+7][i+1]; // ub (dont' chagne ub_x)
    }
  }

  print_tableau(&tab,"negative torque compensation");
  // compensate for negative constraint value

  for(int i = 1; i < tab.m; i++) {
    if(tab.mat[i][0] < 0){
      if(i == 2){ // for the equality constraint
        for(int j = 0; j < 5; j++) {
          tab.mat[2][j] = - tab.mat[2][j]; // just invert equation, don't touch a1
        } 
      } else if(i >= 3 && i <= 6) { // for lb
        for(int j = 0; j <= 9; j++) {
          tab.mat[i][j] = - tab.mat[i][j];
          printf("lb parameter inverted: [%d][%d]\n", i, j);
        }
        tab.mat[i][i+12] = 0;
        tab.mat[0][i+12] = 0;
      } else if(i >= 7 && i <= 10) { // for ub
        for(int j = 0; j <= 13; j++) {
          tab.mat[i][j] = - tab.mat[i][j];
          printf("ub parameter inverted: [%d][%d]\n", i, j);
        }
        tab.mat[i][i+12] = 1;
        tab.mat[0][i+12] = bM;
      }
    }
  }

  print_tableau(&tab,"negative constraint compensation");
  // convert bigM Tableau to normal Simplex Tableau
  for(int j = 0; j < tab.n; j++){
    if(tab.mat[0][j] > bM/2){
      for(int i = 1; i < tab.m; i++){
        if(tab.mat[i][j] == 1){
          // then do row subtraction
          for(int k = 0; k < tab.n; k++){
            tab.mat[0][k] = tab.mat[0][k] - bM * tab.mat[i][k];
            //printf("modified = %.3f\n", tab.mat[0][k]);
          }
          printf("one row taken care of\n");
          break;
        }
      }
    }
  }
          //print_tableau(&tab,"Initial");

  flag = simplex(&tab, T1, T2, T3, T4);

  // turn negative torque back
  if(torque_sign[0] == -1)
    *T1 = - *T1;
  if(torque_sign[1] == -1)
    *T2 = - *T2;
  if(torque_sign[2] == -1)
    *T3 = - *T3;
  if(torque_sign[3] == -1)
    *T4 = - *T4;
  

  yaw_err = beq - (Aeq_1 * *T1 + Aeq_2 * *T2 + Aeq_3 * *T3 + Aeq_4 * *T4); 
  if(flag == 3 && (yaw_err > yaw_err_limit || yaw_err < - yaw_err_limit)){
    flag = 0; // infeasible (not mathmatically)
  }


  return flag;
}


// Simplex functions


void nl(int k){ int j; for(j=0;j<k;j++) putchar('-'); putchar('\n'); }

void print_tableau(Tableau *tab, const char* mes) {
  static int counter=0;
  int i, j;
  printf("\n%d. Tableau %s:\n", ++counter, mes);
  nl(70);

  printf("%-6s%5s", "col:", "b[i]");
  for(j=1;j<tab->n; j++) { printf("    x%d,", j); } printf("\n");

  for(i=0;i<tab->m; i++) {
    if (i==0) printf("max:"); else
    printf("b%d: ", i);
    for(j=0;j<tab->n; j++) {
      if (equal((int)tab->mat[i][j], tab->mat[i][j]))
        printf(" %6d", (int)tab->mat[i][j]);
      else
        printf(" %6.2lf", tab->mat[i][j]);
      }
    printf("\n");
  }
  nl(70);
}

/* Example input file for read_tableau:
     4 5
      0   -0.5  -3 -1  -4 
     40    1     1  1   1 
     10   -2    -1  1   1 
     10    0     1  0  -1  
*/

void pivot_on(Tableau *tab, int row, int col) {
  int i, j;
  double pivot;

  pivot = tab->mat[row][col];
  //assert(pivot>0);
  for(j=0;j<tab->n;j++)
    tab->mat[row][j] /= pivot;
  //assert( equal(tab->mat[row][col], 1. ));

  for(i=0; i<tab->m; i++) { // foreach remaining row i do
    double multiplier = tab->mat[i][col];
    if(i==row) continue;
    for(j=0; j<tab->n; j++) { // r[i] = r[i] - z * r[row];
      tab->mat[i][j] -= multiplier * tab->mat[row][j];
    }
  }
}

// Find pivot_col = most negative column in mat[0][1..n]
int find_pivot_column(Tableau *tab) {
  int j, pivot_col = 1;
  double lowest = tab->mat[0][pivot_col];
  for(j=1; j<tab->n; j++) {
    if (tab->mat[0][j] < lowest) {
      lowest = tab->mat[0][j];
      pivot_col = j;
    }
  }
  //printf("Most negative column in row[0] is col %d = %g.\n", pivot_col, lowest);
  if( lowest >= 0 ) {
    return -1; // All positive columns in row[0], this is optimal.
  }
  return pivot_col;
}

// Find the pivot_row, with smallest positive ratio = col[0] / col[pivot]
int find_pivot_row(Tableau *tab, int pivot_col) {
  int i, pivot_row = 0;
  double min_ratio = -1;
  //printf("Ratios A[row_i,0]/A[row_i,%d] = [",pivot_col);
  for(i=1;i<tab->m;i++){
    double ratio = tab->mat[i][0] / tab->mat[i][pivot_col];
    //printf("%3.2lf, ", ratio);
    if ( (ratio > 0  && ratio < min_ratio ) || min_ratio < 0 ) {
      min_ratio = ratio;
      pivot_row = i;
    }
  }
  //printf("].\n");
  if (min_ratio == -1)
    return -1; // Unbounded.
  //printf("Found pivot A[%d,%d], min positive ratio=%g in row=%d.\n",
      //vot_row, pivot_col, min_ratio, pivot_row);
  return pivot_row;
}

void add_slack_variables(Tableau *tab) {
  int i, j;
  for(i=1; i<tab->m; i++) {
    for(j=1; j<tab->m; j++)
      tab->mat[i][j + tab->n -1] = (i==j);
  }
  tab->n += tab->m -1;
}

void check_b_positive(Tableau *tab) {
  int i;
  for(i=1; i<tab->m; i++)
    i = i;
    assert(tab->mat[i][0] >= 0);
}

// Given a column of identity matrix, find the row containing 1.
// return -1, if the column as not from an identity matrix.
int find_basis_variable(Tableau *tab, int col) {
  int i, xi=-1;
  for(i=1; i < tab->m; i++) {
    if (equal( tab->mat[i][col],1) ) {
      if (xi == -1)
        xi=i;   // found first '1', save this row number.
      else
        return -1; // found second '1', not an identity matrix.

    } else if (!equal( tab->mat[i][col],0) ) {
      return -1; // not an identity matrix column.
    }
  }
  return xi;
}

void print_optimal_vector(Tableau *tab, float* T1, float* T2, float* T3, float* T4){
  int j, xi;
  j = 1;
  xi = find_basis_variable(tab, j);
  *T1 = tab->mat[xi][0]; // actual Torque output
  j += 1;
  xi = find_basis_variable(tab, j);
  *T2 = tab->mat[xi][0]; // actual Torque output
  j += 1;
  xi = find_basis_variable(tab, j);
  *T3 = tab->mat[xi][0]; // actual Torque output
  j += 1;
  xi = find_basis_variable(tab, j);
  *T4 = tab->mat[xi][0]; // actual Torque output
 }
  

int simplex(Tableau *tab, float* T1, float* T2, float* T3, float* T4) {
  int loop=0;
  int flag = -1;
  //add_slack_variables(tab);
  //check_b_positive(tab);
  print_tableau(tab,"Padded with slack variables");
  while( ++loop ) {
    int pivot_col, pivot_row;

    printf(" Iteration: %d ", loop);

    pivot_col = find_pivot_column(tab);
    if( pivot_col < 0 ) {
      printf("\nFound optimal value=A[0,0]=%3.2lf (no negatives in row 0).\n",
      tab->mat[0][0]);
      print_optimal_vector(tab, T1, T2, T3, T4);
      flag = 3;
      return flag; // TODO: add return value of Simplex
    }
    //printf("Entering variable x%d to be made basic, so pivot_col=%d.\n",
    //  pivot_col, pivot_col);

    pivot_row = find_pivot_row(tab, pivot_col);
    if (pivot_row < 0) {
      printf("unbounded (no pivot_row).\n");
      flag = 2;
      return flag;
    }
    //printf("Leaving variable x%d, so pivot_row=%d\n", pivot_row, pivot_row);

    pivot_on(tab, pivot_row, pivot_col);
    //print_tableau(tab,"After pivoting");
    //print_optimal_vector(tab, "Basic feasible solution");
    
    if(loop > 20) {
      printf("\nToo many iterations > %d.\n", loop);
      flag = 1;
      return flag;
    }
  }
  return 0;
}

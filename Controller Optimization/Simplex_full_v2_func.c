// full input data set (Feb_7) for Simplex iteration statistics

// modifications over v1: suppress error for negative first column value
//                        input data set changed (to a better accuracy one)
//                        log output to csv file
//                        adapt code structure to be able to be called from Simulink
#include "Simplex_full_v2_func.h"

static const double epsilon   = 1.0e-8;
int equal(double a, double b) { return fabs(a-b) < epsilon; }

// typedef struct {
//   int m, n; // m=rows, n=columns, mat[m x n]
//   double mat[M][N];
// } Tableau;

int simplex_func(float T2F_1, float T2F_2, float T2F_3, float T2F_4, 
  float b, 
  float A_1, float A_2, float A_3, float A_4, 
  float beq, float Aeq_1, float Aeq_2, float Aeq_3, float Aeq_4,
  float lb_1, float lb_2, float lb_3, float lb_4,
  float ub_1, float ub_2, float ub_3, float ub_4,
  float* T1, float* T2, float* T3, float* T4)
{
  int violation_count;


  // all the parameters & contraints are now in simu (array)
      
  Tableau tab  = { 12, 5, {                            // eg: Size of tableau [4 rows x 5 columns ]
      {  0.0 , -T2F_1 , -T2F_2 , -T2F_3 , -T2F_4,   },  // -T2F
      { b ,  A_1 ,  A_2 , A_3 ,  A_4 ,   },  // b, A 
      { beq+0.00001, Aeq_1 , Aeq_2 , Aeq_3 , Aeq_4 ,   },  //  beq, Aeq  // changed a "-"
      { -beq+0.00001, - Aeq_1 , - Aeq_2 , - Aeq_3 , - Aeq_4,   },   //   -beq, -Aeq
      { -lb_1, -1, 0, 0, 0, },   // lb
      { -lb_2, 0, -1, 0, 0,  },
      { -lb_3, 0, 0, -1, 0,  },
      { -lb_4, 0, 0, 0, -1,  },
      { ub_1, 1, 0, 0, 0, },    // ub
      { ub_2, 0, 1, 0, 0,  },
      { ub_3, 0, 0, 1, 0,  },
      { ub_4, 0, 0, 0, 1,  },
    }
  };

          //print_tableau(&tab,"Initial");

          int k;
          int k_col; 
          float tmp_simu;

          float lb_ub[8] = {lb_1, lb_2, lb_3, lb_4, ub_1, ub_2, ub_3, ub_4};
          int Tx_neg[4] = {0, 0, 0, 0};

          for(k = 14; k<= 17; k++) {// modify tab if Tx is always negative
            if((lb_ub[k-14] < 0) && (lb_ub[k-10] < 0)) { // Tx_new = - Tx, then revert back in the final output
              printf("\ncondition met !!!\n");
              // assumption: abs(lb) > abs(ub)
              tmp_simu = tab.mat[k-10][0];           // switch lb and ub
              tab.mat[k-10][0] = tab.mat[k-6][0];
              tab.mat[k-6][0] = tmp_simu;
              // negate multiplier in row 0 to 3
              k_col = k - 13;
              //tab.mat[0][k_col] = - tab.mat[0][k_col];
              tab.mat[1][k_col] = - tab.mat[1][k_col];
              tab.mat[2][k_col] = - tab.mat[2][k_col];
              tab.mat[3][k_col] = - tab.mat[3][k_col];

              Tx_neg[k - 14] = 1;
            }
          }
          //print_tableau(&tab,"Modified");
          simplex(&tab, T1, T2, T3, T4);
          float zero_tmp = 0;
          if(Tx_neg[0] == 1){
            *T1 = zero_tmp - *T1;
          }
          if(Tx_neg[1] == 1){
            *T2 = zero_tmp - *T2;
          }
          if(Tx_neg[2] == 1){
            *T3 = zero_tmp - *T3;
          }
          if(Tx_neg[3] == 1){
            *T4 = zero_tmp - *T4;
          }

          //violation_count = check_constraint(simu, T1, T2, T3, T4, 1.05, csv);
     

    return 0;

}

// check output of Simplex, how many constraint(s) it violates
// input: Tableau - target and contraints matrix
//        T1, T2, T3, T4 - Simplex output
//        err - error tolerance (> 1)
// output: number of violated constraints
// int check_constraint(float* simu, float T1, float T2, float T3, float T4, float err, FILE* csv){
//   int count = 0;
//   float yaw_rate_err; // in percentage
//   float A_dot_Tx = simu[5] * T1 + simu[6] * T2 + simu[7] * T3 + simu[8] * T4;
//   float Aeq_dot_Tx = simu[10] * T1 + simu[11] * T2 + simu[12] * T3 + simu[13] * T4;
// 
//   if((simu[4] * err) < A_dot_Tx){
//     count += 1;
//     printf("\n Power Violation \n");
//   }
//   if(fabsf(simu[9] - Aeq_dot_Tx) > 0.01) {
//     count += 1;
//     yaw_rate_err = (Aeq_dot_Tx - simu[9]);
//     printf("\n Yaw Rate Violation (%.4f)\n", yaw_rate_err);
//   }
//   if((simu[14] > T1) || (simu[15] > T2) || (simu[16] > T3) || (simu[17] > T4)) {
//     count += 1;
//     printf("\n Lower Bound Violation \n");
//   }
//   if((simu[18] < T1) || (simu[19] < T2) || (simu[20] < T3) || (simu[21] < T4)) {
//     count += 1;
//     printf("\n Upper Bound Violation \n");
//   }
//     
//   return count;
// }

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
  

void simplex(Tableau *tab, float* T1, float* T2, float* T3, float* T4) {
  int loop=0;
  add_slack_variables(tab);
  //check_b_positive(tab);
  //print_tableau(tab,"Padded with slack variables");
  while( ++loop ) {
    int pivot_col, pivot_row;

    printf(" Iteration: %d ", loop);

    pivot_col = find_pivot_column(tab);
    if( pivot_col < 0 ) {
      printf("\nFound optimal value=A[0,0]=%3.2lf (no negatives in row 0).\n",
      tab->mat[0][0]);
      print_optimal_vector(tab, T1, T2, T3, T4);
      break; // TODO: add return value of Simplex
    }
    //printf("Entering variable x%d to be made basic, so pivot_col=%d.\n",
    //  pivot_col, pivot_col);

    pivot_row = find_pivot_row(tab, pivot_col);
    if (pivot_row < 0) {
      printf("unbounded (no pivot_row).\n");
      break;
    }
    //printf("Leaving variable x%d, so pivot_row=%d\n", pivot_row, pivot_row);

    pivot_on(tab, pivot_row, pivot_col);
    //print_tableau(tab,"After pivoting");
    //print_optimal_vector(tab, "Basic feasible solution");
    
    if(loop > 20) {
      printf("\nToo many iterations > %d.\n", loop);
      break;
    }
  }
}

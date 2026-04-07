#include "minOrMax.h"

void minimum(const float x[28], float ex[4])
{
  int i;
  int j;
  for (j = 0; j < 4; j++) {
    float f;
    f = x[7 * j];
    for (i = 0; i < 6; i++) {
      float f1;
      f1 = x[(i + 7 * j) + 1];
      if (f > f1) {
        f = f1;
      }
    }
    ex[j] = f;
  }
}

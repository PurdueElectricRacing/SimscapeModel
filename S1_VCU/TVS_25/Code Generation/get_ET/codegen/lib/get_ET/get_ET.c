#include "get_ET.h"
#include "get_ET_types.h"

void get_ET(const struct0_T *p, struct1_T *y)
{
  double d;
  d = y->TH_CF * p->MAX_TORQUE_NOM;
  y->TO_ET[0] = d;
  y->TO_ET[1] = d;
}
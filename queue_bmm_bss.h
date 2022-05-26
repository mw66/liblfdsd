#ifndef queue_bmm_bss_h
#define queue_bmm_bss_h

// bmm & bss queue has the same API interface:
// https://www.liblfds.org/mediawiki/index.php?title=r7.1.1:Queue_(bounded,_single_producer,_single_consumer)
// https://www.liblfds.org/mediawiki/index.php?title=r7.1.1:Queue_(bounded,_many_producer,_many_consumer)
// https://www.liblfds.org/mediawiki/index.php?title=r7.1.1:Queue_(unbounded,_many_producer,_many_consumer)


#include <stdbool.h>
#include <stdlib.h>
#include "liblfds711.h"


#define INLINE // dpp will remove 'inline' to generate .d; and in .c we need generate the symbol

INLINE bool is_power_of_two(size_t x) {
  return (x >= 2) && ((x & (x - 1)) == 0);
}

INLINE void ensure_lfds_valid_init_on_current_logical_core() {
  LFDS711_MISC_MAKE_VALID_ON_CURRENT_LOGICAL_CORE_INITS_COMPLETED_BEFORE_NOW_ON_ANY_OTHER_LOGICAL_CORE;
}


#include "queue_bmm.h"
#include "queue_bss.h"
#include "queue_umm.h"

#endif//queue_bmm_bss_h

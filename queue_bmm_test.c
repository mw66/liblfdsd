#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "queue_bmm_bss.h"

struct test_data
{
  char
    name[64];
};

int use_liblfds711_h_main()  // use raw "liblfds711.h"
{
  struct lfds711_queue_bmm_element
    qbmme[8]; // TRD : must be a positive integer power of 2 (2, 4, 8, 16, etc)

  struct lfds711_queue_bmm_state
    qbmms;

  struct test_data
    td,
    *temp_td;

  lfds711_queue_bmm_init_valid_on_current_logical_core( &qbmms, qbmme, 8, NULL );

  strcpy( td.name, "Madge The Skutter" );

  lfds711_queue_bmm_enqueue( &qbmms, NULL, &td );

  lfds711_queue_bmm_dequeue( &qbmms, NULL, (void**)(&temp_td) );

  printf( "skutter name = %s %d\n", temp_td->name, LFDS711_PAL_ATOMIC_ISOLATION_IN_BYTES );

  lfds711_queue_bmm_cleanup( &qbmms, NULL );

  return( EXIT_SUCCESS );
}

int use_queue_bmm_h_main() {  // use our wrapper "queue_bmm.h"
  struct test_data
    td,
    *temp_td;

  void* vp;
  int ok;

  strcpy( td.name, "Madge The Skutter" );

  c_queue_bmm* queue = queue_bmm_new(8);
  queue_bmm_push(queue, &td);
  temp_td = queue_bmm_pop(queue, &ok);
  queue_bmm_destroy(queue);

  printf( "skutter name = %s %lu %d\n", temp_td->name, sizeof(vp), LFDS711_PAL_ATOMIC_ISOLATION_IN_BYTES );
  return( EXIT_SUCCESS );
}


int main() {  // use our wrapper "queue_bmm.h"
  use_liblfds711_h_main();
  use_queue_bmm_h_main();
}


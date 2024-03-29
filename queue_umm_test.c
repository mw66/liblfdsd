#include <stdio.h>
#include <stdlib.h>
#include "liblfds711.h"
#include "queue_bmm_bss.h"

struct test_data
{
  struct lfds711_queue_umm_element
    qe;

  int
    number;
};

// https://www.liblfds.org/mediawiki/index.php?title=r7.1.1:Queue_(unbounded,_many_producer,_many_consumer)
int use_liblfds711_h_main() {  // use raw "liblfds711.h"
  int long long unsigned
    loop;

  struct lfds711_queue_umm_element
    *qe,
    qe_dummy;

  struct lfds711_queue_umm_state
    qs;

  struct test_data
    *td,
    *td_temp;

  lfds711_queue_umm_init_valid_on_current_logical_core( &qs, &qe_dummy, NULL );

  td = malloc( sizeof(struct test_data) * 10 );

  // TRD : queue ten elements
  for( loop = 0 ; loop < 10 ; loop++ )
  {
    // TRD : we enqueue the numbers 0 to 9
    td[loop].number = (int) loop;
    LFDS711_QUEUE_UMM_SET_VALUE_IN_ELEMENT( td[loop].qe, &td[loop] );
    lfds711_queue_umm_enqueue( &qs, &td[loop].qe );
  }

  // TRD : dequeue until the queue is empty
  while( lfds711_queue_umm_dequeue(&qs, &qe) )
  {
    struct test_data* temp_td = LFDS711_QUEUE_UMM_GET_VALUE_FROM_ELEMENT( *qe );

    // TRD : we dequeue the numbers 0 to 9
    printf( "number = %d\n", temp_td->number );
  }

  lfds711_queue_umm_cleanup( &qs, NULL );

  free( td );

  return( EXIT_SUCCESS );
}

int use_queue_umm_h_main() {  // use our wrapper "queue_umm.h"
  int ok;
  void* value;

  c_queue_umm* queue = queue_umm_new(8);
  for (int i = 5; i--> -5; ) {   // test both positive, and negative int
    value = (void*)((size_t)i);  // as unsigned is ok
    queue_umm_push(queue, value);  // make sure it's the var `value` holds the value we want to push in!
  }

  for (int i = 10; i--> 0; ) {
    void *j = queue_umm_pop(queue, &ok);
    printf( "pop = %d\n", (int)((size_t)j));
  }
  queue_umm_destroy(queue);

  return( EXIT_SUCCESS );
}

int main() {
  use_liblfds711_h_main();
  use_queue_umm_h_main();
  return( EXIT_SUCCESS );
}


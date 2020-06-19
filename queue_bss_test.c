#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "liblfds711.h"

struct test_data
{
  char
    name[64];
};

int main()
{
  struct lfds711_queue_bss_element
    qbsse[8];

  struct lfds711_queue_bss_state
    qbsss;

  struct test_data
    td,
    *temp_td;

  lfds711_queue_bss_init_valid_on_current_logical_core( &qbsss, qbsse, 8, NULL );

  strcpy( td.name, "Bob The Skutter" );

  lfds711_queue_bss_enqueue( &qbsss, NULL, &td );

  lfds711_queue_bss_dequeue( &qbsss, NULL, (void**)(&temp_td) );

  printf( "skutter name = %s\n", temp_td->name );

  lfds711_queue_bss_cleanup( &qbsss, NULL );

  return( EXIT_SUCCESS );
}

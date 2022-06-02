#ifndef queue_umm_h
#define queue_umm_h

// this file is intended to be included from liblfdsd.h

typedef struct {
  // https://port70.net/~nsz/c/c11/n1570.html#6.7.2.1p15
  // Within a structure object, the non-bit-field members and the units in which bit-fields reside have addresses that increase in the order in which they are declared. A pointer to a structure object, suitably converted, points to its initial member (or if that member is a bit-field, then to the unit in which it resides), and vice versa. There may be unnamed padding within a structure object, but not at its beginning.
  struct lfds711_queue_umm_state qstate;
  struct lfds711_queue_umm_element* element;
  lfds711_pal_uint_t number_elements;
  void *user_state;  // do we need this? always set to NULL now
} c_queue_umm;

// create a new queue
// size: will set to 1, this arg is not needed for unbounded queue, only to make liblfds.dpp easier so all the queue have the same interface
INLINE c_queue_umm* queue_umm_new(size_t size) {
  size = 1;  // for a single element
  c_queue_umm* queue = aligned_alloc(LFDS711_PAL_ATOMIC_ISOLATION_IN_BYTES, sizeof(c_queue_umm));
  queue->number_elements = size;
  queue->user_state = NULL;
  // https://www.liblfds.org/mediawiki/index.php?title=r7.1.1:Function_lfds711_queue_umm_init_valid_on_current_logical_core
  // A pointer to a user-allocated LFDS711_PAL_ATOMIC_ISOLATION_IN_BYTES aligned struct lfds711_queue_umm_element.
  // The queue data structure contains a single dummy element; this is that dummy element.
  // The queue requires a single dummy element to function. This element is in fact used normally - it will emerge from the queue
  // - and so it must be possible for the user to treat it, when it does emerge, as he would do any other element.
  // NOTE: base on queue_umm_test.c, it is the 1st element that will be pop-ed! ref:queue_umm_destroy()
  // TODO: pre-allocate some lfds711_queue_umm_element?
  queue->element = aligned_alloc(LFDS711_PAL_ATOMIC_ISOLATION_IN_BYTES, sizeof(struct lfds711_queue_umm_element));
  // printf("allc: %p\n", (void*)(queue->element));

  lfds711_queue_umm_init_valid_on_current_logical_core(&(queue->qstate), queue->element, queue->user_state);

  return queue;
}

// only push basic type of size < size_t; or object pointer
INLINE bool queue_umm_push(c_queue_umm* queue, container_value_t value) {
  // each time, we push, we alloc one lfds711_queue_umm_element
  // TODO: add a default to NULL lfds711_queue_umm_element pointer, to use the pre-allocate lfds711_queue_umm_element when available?
  struct lfds711_queue_umm_element* qe = aligned_alloc(LFDS711_PAL_ATOMIC_ISOLATION_IN_BYTES, sizeof(struct lfds711_queue_umm_element));
  // printf("allc: %p\n", (void*)qe);
  if (qe) {
    LFDS711_QUEUE_UMM_SET_VALUE_IN_ELEMENT((*qe), (void*)value);  // the macro takes A pointer, which will be cast by the macro to a void *, which the value in queue_element is set to.
    lfds711_queue_umm_enqueue(&(queue->qstate), qe);
    return true;  // unbounded queue, always successful
  }
  return false;
}

// return the element, if ok is true; otherwise 0
INLINE container_value_t queue_umm_pop(c_queue_umm* queue, int* ok) {
  struct lfds711_queue_umm_element *qe = NULL;
  void* value = NULL;
  *ok = lfds711_queue_umm_dequeue(&(queue->qstate), &qe);
  if (*ok) {  // Dequeuing only fails if the queue is empty.
    value = LFDS711_QUEUE_UMM_GET_VALUE_FROM_ELEMENT(*qe);  // the macro Returns a void pointer, the value from the element.
    // printf("free: %p\n", (void*)qe);
    free(qe);  // after get the value; whenever we pop, free the alloc-ed lfds711_queue_umm_element, ref:queue_umm_push
    return (container_value_t)value;
  }
  return 0;
}


// length
INLINE size_t queue_umm_length(c_queue_umm* queue) {
  lfds711_pal_uint_t len;
  lfds711_queue_umm_query(&(queue->qstate), LFDS711_QUEUE_UMM_QUERY_SINGLETHREADED_GET_COUNT, NULL, &len);
  return len;
}

// destroy the queue
INLINE void queue_umm_destroy(c_queue_umm* queue) {
  lfds711_queue_umm_cleanup(&(queue->qstate), NULL );
  // printf("free: %p\n", (void*)(queue->element));
  // free(queue->element);  // free(): double free detected in tcache 2
  // NOTE: we will have a memory leak here: the last queue_umm_push lfds711_queue_umm_element will not be free-ed
  free(queue);
}


#endif//queue_umm_h

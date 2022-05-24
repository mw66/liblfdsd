#ifndef queue_umm_h
#define queue_umm_h

typedef struct {
  // https://port70.net/~nsz/c/c11/n1570.html#6.7.2.1p15
  // Within a structure object, the non-bit-field members and the units in which bit-fields reside have addresses that increase in the order in which they are declared. A pointer to a structure object, suitably converted, points to its initial member (or if that member is a bit-field, then to the unit in which it resides), and vice versa. There may be unnamed padding within a structure object, but not at its beginning.
  struct lfds711_queue_umm_state qstate;
  struct lfds711_queue_umm_element* element;
  lfds711_pal_uint_t number_elements;
  void *user_state;  // do we need this? always set to NULL now
} c_queue_umm;

// create a new queue
// size: must be a positive integer power of 2 (2, 4, 8, 16, etc)
INLINE c_queue_umm* queue_umm_new(size_t size) {
  if (!is_power_of_two(size)) {
    return NULL;  // TODO: resize it!
  }
  c_queue_umm* queue = aligned_alloc(LFDS711_PAL_ATOMIC_ISOLATION_IN_BYTES, sizeof(c_queue_umm));
  queue->number_elements = size;
  queue->user_state = NULL;
  // https://www.liblfds.org/mediawiki/index.php?title=r7.1.1:Function_lfds711_queue_umm_init_valid_on_current_logical_core
  // There are no alignment requirements for this allocation.
  queue->element = malloc(size*sizeof(struct lfds711_queue_umm_element));

  lfds711_queue_umm_init_valid_on_current_logical_core(&(queue->qstate), queue->element, size, queue->user_state);

  return queue;
}

// only push basic type of size < size_t; or object pointer
INLINE bool queue_umm_push(c_queue_umm* queue, void* value) {
  int r = lfds711_queue_umm_enqueue(&(queue->qstate), NULL, value);
  return r;  // 0 when full
}

// return element, if ok is true; otherwise NULL
INLINE void* queue_umm_pop(c_queue_umm* queue, int* ok) {
  void* value = NULL;
  *ok = lfds711_queue_umm_dequeue(&(queue->qstate), NULL, &value);
  if (*ok) {
    return value;
  }
  return NULL;
}


// length
INLINE size_t queue_umm_length(c_queue_umm* queue) {
  lfds711_pal_uint_t len;
  lfds711_queue_umm_query(&(queue->qstate), LFDS711_QUEUE_BMM_QUERY_GET_POTENTIALLY_INACCURATE_COUNT, NULL, &len);
  return len;
}

// destroy the queue
INLINE void queue_umm_destroy(c_queue_umm* queue) {
  lfds711_queue_umm_cleanup(&(queue->qstate), NULL );
  free(queue->element);
  free(queue);
}


#endif//queue_umm_h

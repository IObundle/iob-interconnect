//memory access macros
#define MEM_GET(type, location, value) (*((type*) (location)))
#define MEM_SET(type, location, value) (*((type*) (location)) = value)

//stream access macros
#define IO_SET(base, location, value) (*((volatile int*) (base + (sizeof(int)) * location)) = value)
#define IO_GET(base, location)        (*((volatile int*) (base + (sizeof(int)) * location)))



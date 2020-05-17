//memory access macros
#define MEM_PUTINT(location, value) (*((int*) (location)) = value)

//stream access macros
#define MEMSET(base, location, value) (*((volatile int*) (base + (sizeof(int)) * location)) = value)
#define MEMGET(base, location)        (*((volatile int*) (base + (sizeof(int)) * location)))



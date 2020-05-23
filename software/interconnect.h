//memory access macros
#define RAM_GET(type, location, value) (*((type*) (location)))
#define RAM_SET(type, location, value) (*((type*) (location)) = value)

//stream access macros
#define MEMSET(base, location, value) (*((volatile int*) (base + (sizeof(int)) * location)) = value)
#define MEMGET(base, location)        (*((volatile int*) (base + (sizeof(int)) * location)))



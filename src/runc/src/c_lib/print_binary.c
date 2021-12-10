// HEADER_START
#include <stddef.h>
#include <assert.h>
#include <printf.h>
// HEADER_END
// TEST_HEADER_START
#include <stdio.h>
#include <stdlib.h>
// TEST_HEADER_END

// FUNCTIONS_START
static char *itobstr(size_t len, unsigned long val)
{
    #define max_num_bits (sizeof(val)*8)
    assert(max_num_bits >= len);
    static char string[max_num_bits+1] = {0};
    for (int i = 0 ; i < len ; i++) {
        string[i] = (val >> (len - 1 - i)) & 0x1 > 0 ? '1' : '0';
    }
    string[len] = 0;
    return string;
}

int print_binary(FILE *stream, const struct printf_info *info, const void *const *args)
{
    int retval = -1;
    int num_bits = info->prec > 0 ? info->prec : 8;
    char *buffer = calloc(num_bits + 1, sizeof(char));
    unsigned int val = *((unsigned int *)args[0]);
    for (int i = 0 ; i < num_bits ; i++) {
        buffer[i] = (val >> (num_bits - 1 - i)) & 0x1 > 0 ? '1' : '0';
    }
    retval = fprintf(stream, "%s", buffer);
    free(buffer);
    return retval;
}

int print_binary_arginfo(const struct printf_info *info, size_t n, int *argtypes)
{
    if (n > 0) {
        argtypes[0] = PA_INT;
    }
    return 1;
}
// FUNCTIONS_END

// TEST_START
int main(int argc, char *argv[])
{
    // MAIN_CODE_START
    register_printf_function('B', print_binary, print_binary_arginfo);
    // MAIN_CODE_END
    if (argc < 3) {
        fprintf(stderr, "Usage: %s VAL LEN\n", argv[0]);
        return 1;
    }
    int val = strtol(argv[1], NULL, 0);
    size_t len = strtol(argv[2], NULL, 0);
    printf("%#X is %B in binary\n", val, val);
    return 0;
}
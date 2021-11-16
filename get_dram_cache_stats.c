#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <sys/ioctl.h>
#include <linux/perf_event.h>
#include <asm/unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

static long perf_event_open(struct perf_event_attr *hw_event, pid_t pid,
        int cpu, int group_fd, unsigned long flags)
{
    int ret;

    ret = syscall(__NR_perf_event_open, hw_event, pid, cpu,
            group_fd, flags);
    return ret;
}

enum dram_cache_stats {
    LOCAL_DRAM_ACCESS = 0,
    LOCAL_PMM_ACCESS,
    REMOTE_DRAM_ACCESS,
    REMOTE_PMM_ACCESS,
    NUM_COUNTERS
};

int main(int argc, char **argv)
{
    struct perf_event_attr pe_[NUM_COUNTERS];
    int i;
    int time;
    int cpu;

    if (argc < 1) {
        printf("usage: ./get_dram_cache_stast [cpu] [time] \n");
        return 0;
    }
    cpu = atoi(argv[1]);
    time = atoi(argv[2]);

    for (i = 0; i < NUM_COUNTERS; i++) {
        memset(&pe_[i], 0, sizeof(struct perf_event_attr));
        pe_[i].type = PERF_TYPE_RAW;
        pe_[i].size = sizeof(struct perf_event_attr);
        pe_[i].disabled = 1;
        pe_[i].inherit = 1;
        pe_[i].exclude_kernel = 0;
        pe_[i].exclude_hv = 1;

        if ( i == LOCAL_DRAM_ACCESS ) {
            pe_[i].config = 0x1d3;
        } else if ( i == LOCAL_PMM_ACCESS ) {
            pe_[i].config = 0x80d1;
        } else if ( i == REMOTE_DRAM_ACCESS ) {
            pe_[i].config = 0x2d3;
        } else if ( i == REMOTE_PMM_ACCESS ) {
            pe_[i].config = 0x10d3;
        }
    }

    // mem_load_l3_miss_retired.local_dram,mem_load_retired.local_pmm,mem_load_l3_miss_retired.remote_dram,mem_load_l3_miss_retired.remote_pmm
    long long count_[NUM_COUNTERS];
    int fd_[NUM_COUNTERS];

    for (i = 0; i < NUM_COUNTERS; i++) {
        fd_[i] = perf_event_open(&pe_[i], -1, cpu, -1, 0);
        if (fd_[i] == -1) {
            fprintf(stderr, "Error opening leader %llx\n", pe_[i].config);
            exit(EXIT_FAILURE);
        }
    }

    for (i = 0; i < NUM_COUNTERS; i++) {
        ioctl(fd_[i], PERF_EVENT_IOC_RESET, 0);
        ioctl(fd_[i], PERF_EVENT_IOC_ENABLE, 0);
    }

    // You are supposed to measure the below execution 
    char buf[100];
    sprintf(buf, "sleep %d\n", time);
    system(buf);
    //system("/bin/echo Foo is my name");


    for (i = 0; i < NUM_COUNTERS; i++) {
        ioctl(fd_[i], PERF_EVENT_IOC_DISABLE, 0);
        read(fd_[i], &count_[i], sizeof(long long));

        if ( i == LOCAL_DRAM_ACCESS ) {
            printf("LOCAL_DRAM_ACCESS: ");
        } else if ( i == LOCAL_PMM_ACCESS ) {
            printf("LOCAL_PMM_ACCESS: ");
        } else if ( i == REMOTE_DRAM_ACCESS ) {
            printf("REMOTE_DRAM_ACCESS: ");
        } else if ( i == REMOTE_PMM_ACCESS ) {
            printf("REMOTE_PMM_ACCESS: ");
        }
        printf("%lld\n", count_[i]);

        close(fd_[i]);
    }
}

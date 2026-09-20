#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>

#define N 1000000

int main(int argc, char **argv) {
    MPI_Init(&argc, &argv);

    int rank, size;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    int *array = (int *)malloc(N * sizeof(int));

    if (rank == 0) {
        for (int i = 0; i < N; i++) array[i] = i + 1;
    }

    double start = MPI_Wtime();

    /* Broadcast whole array to everyone */
    MPI_Bcast(array, N, MPI_INT, 0, MPI_COMM_WORLD);

    int chunk_size = N / size;
    int start_idx = rank * chunk_size;
    int end_idx = start_idx + chunk_size;

    long long local_sum = 0;
    for (int i = start_idx; i < end_idx; i++)
        local_sum += array[i];

    if (rank != 0) {
        MPI_Send(&local_sum, 1, MPI_LONG_LONG, 0, 0, MPI_COMM_WORLD);
    } else {
        long long total_sum = local_sum;
        for (int r = 1; r < size; r++) {
            long long recv_sum;
            MPI_Recv(&recv_sum, 1, MPI_LONG_LONG, r, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
            total_sum += recv_sum;
        }
        double elapsed = MPI_Wtime() - start;
        long long expected = (long long)N * (N + 1) / 2;
        printf("\n[Ex1 Bcast] Total sum: %lld, Time: %.4f sec\n", total_sum, elapsed);
    }

    free(array);
    MPI_Finalize();
    return 0;
}
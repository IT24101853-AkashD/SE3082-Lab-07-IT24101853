CC = mpicc
CFLAGS = -Wall -O2

all: sum_bcast sum_scatter sum_gather sum_reduce sum_allreduce sum_scan

sum_bcast: Exercise01/sum_bcast.c
	$(CC) $(CFLAGS) -o Exercise01/sum_bcast.exe Exercise01/sum_bcast.c

sum_scatter: Exercise02/sum_scatter.c
	$(CC) $(CFLAGS) -o Exercise02/sum_scatter.exe Exercise02/sum_scatter.c

sum_gather: Exercise03/sum_gather.c
	$(CC) $(CFLAGS) -o Exercise03/sum_gather.exe Exercise03/sum_gather.c

sum_reduce: Exercise04/sum_reduce.c
	$(CC) $(CFLAGS) -o Exercise04/sum_reduce.exe Exercise04/sum_reduce.c

sum_allreduce: Exercise05/sum_allreduce.c
	$(CC) $(CFLAGS) -o Exercise05/sum_allreduce.exe Exercise05/sum_allreduce.c

sum_scan: Exercise06/sum_scan.c
	$(CC) $(CFLAGS) -o Exercise06/sum_scan.exe Exercise06/sum_scan.c

run: all
	@echo "--- Running Exercise 1 (Bcast) ---"
	mpirun -np 4 Exercise01/sum_bcast.exe
	@echo "--- Running Exercise 2 (Scatter) ---"
	mpirun -np 4 Exercise02/sum_scatter.exe
	@echo "--- Running Exercise 3 (Gather) ---"
	mpirun -np 4 Exercise03/sum_gather.exe
	@echo "--- Running Exercise 4 (Reduce) ---"
	mpirun -np 4 Exercise04/sum_reduce.exe
	@echo "--- Running Exercise 5 (Allreduce) ---"
	mpirun -np 4 Exercise05/sum_allreduce.exe
	@echo "--- Running Exercise 6 (Scan) ---"
	mpirun -np 4 Exercise06/sum_scan.exe

clean:
	rm -f Exercise*/*.exe

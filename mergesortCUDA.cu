#include <stdio.h>
#include <stdlib.h>
#include <cuda_runtime.h>

//Merge realizado no device
__device__ void merge(int arr[], int l, int m, int r)
{
    int i, j, k;
    int n1 = m - l + 1;
    int n2 = r - m;

    int *L = (int*)malloc(n1 * sizeof(int));
    int *R = (int*)malloc(n2 * sizeof(int));

    for (i = 0; i < n1; i++)
        L[i] = arr[l + i];
    for (j = 0; j < n2; j++)
        R[j] = arr[m + 1 + j];

    i = 0;
    j = 0;
    k = l;
    while (i < n1 && j < n2) {
        if (L[i] <= R[j]) {
            arr[k] = L[i];
            i++;
        }
        else {
            arr[k] = R[j];
            j++;
        }
        k++;
    }

    while (i < n1) {
        arr[k] = L[i];
        i++;
        k++;
    }

    while (j < n2) {
        arr[k] = R[j];
        j++;
        k++;
    }

    free(L);
    free(R);
}

//Kernel do mergeSort que realiza chamadas recursivas
__global__ void mergeSort(int arr[], int l, int r)
{
    if (l < r) {
        int m = l + (r - l) / 2;
        mergeSort<<<1,1>>>(arr, l, m);
        mergeSort<<<1,1>>>(arr, m + 1, r);
        merge(arr, l, m, r);
    }
}

void printArray(int A[], int size)
{
    int i;
    for (i = 0; i < size; i++)
        printf("%d ", A[i]);
    printf("\n");
}

int main()
{
    int arr_size;
    fscanf(stdin, "%d", &arr_size);
    int *arr = (int*)malloc(arr_size * sizeof(int));

    for(int i = 0; i<arr_size; i++){
        scanf("%d", &arr[i]);
    }

    printf("Given array is \n");
    printArray(arr, arr_size);

    int *d_arr;
    cudaMalloc((void**)&d_arr, arr_size * sizeof(int));
    cudaMemcpy(d_arr, arr, arr_size * sizeof(int), cudaMemcpyHostToDevice);

    mergeSort<<<1,1>>>(d_arr, 0, arr_size - 1);

    cudaMemcpy(arr, d_arr, arr_size * sizeof(int), cudaMemcpyDeviceToHost);

    printf("\nSorted array is \n");
    printArray(arr, arr_size);

    free(arr);
    cudaFree(d_arr);

    return 0;
}
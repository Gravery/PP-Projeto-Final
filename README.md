# Programação Paralela - Projeto-Final

Aluno: Guilherme Calça
RA: 790759

O código trabalhado na paralelização foi o MergeSort.

O MergeSort é um algoritmo recursivo de ordenação que subdivide um vetor em pedaços menores para depois juntá-los realizando um merge e ordenando o vetor.
A estratégia de paralelização para este problema está um realizar as chamadas recursivas da função de forma concorrente e esperar que elas terminem para realizar o merge de forma sequencial.

Foi realizada a paralelização com OpenMP e CUDA, sendo que a abordagem de OpenMP consiste na criação de seções paralelas para as chamadas recursivas criando duas threads para as duas chamadas do MergeSort que subdividem o vetor. Essa paralelização pode obter um speedup em condições ideias de até 2x.

Em CUDA o MergeSort se torna uma função do kernel, sendo trabalhado na GPU com as duas divisões também trabalhando de forma paralela havendo a possibilidade de maior ganho de desempenho em relação a OpenMP por conta das operações realizadas em GPU.

Os resultados obtidos foram satisfatórios com certo ganho de desempenho por parte do OpenMP e, como esperado, um ganho maior por parte da versão em CUDA. As duas versões superaram a versão sequencial, porém CUDA possui maior escalabilidade e consegue manter tempos menores conforme o tamanho do vetor cresce, enquanto OpenMP sofre perdas consideráveis quando escalado a tamanhos maiores.

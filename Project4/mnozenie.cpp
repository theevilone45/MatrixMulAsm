#include <iostream>
using namespace std;

/**
	x->height1
	y->width1 height2
	z->width2
**/
extern "C"
void pomnoz(int x, int y, int z, int* matrix1, int* matrix2, int* result);

void pomnoz_w_c(int x, int y, int z, int* matrix1, int* matrix2, int* result);

int pomnoz_wiersz_przez_kolumne(int wiersz, int kolumna, int x, int y, int z, int ilosc_mnozen, int* matrix1, int* matrix2);

int main()
{
	int x, y, z;
	cin >> x >> y >> z;

	int* matrix1 = new int[x*y];
	int* matrix2 = new int[y*z];
	int* result = new int[x*z];

	for (int i = 0; i < x*y; i++)
		cin >> matrix1[i];

	for (int i = 0; i < y*z; i++)
		cin >> matrix2[i];

	pomnoz(x, y, z, matrix1, matrix2, result);

	for (int i = 0; i < x*z; i++)
	{
		cout << result[i] << " ";
		if ((i+1)%z == 0)
			cout << endl;
	}

	return 0;
}

int pomnoz_wiersz_przez_kolumne(int wiersz, int kolumna, int x, int y, int z, int ilosc_mnozen ,int* matrix1, int* matrix2)
{
	int result = 0;
	for (int i = 0; i < ilosc_mnozen; i++)
		result += (matrix1[wiersz*y+i] * matrix2[i*z+kolumna]);
	return result;
}

void pomnoz_w_c(int x, int y, int z, int* matrix1, int* matrix2, int* result)
{
	for (int i = 0; i < x; i++)
	{
		for (int j = 0; j < z; j++)
		{
			result[i*z + j] = pomnoz_wiersz_przez_kolumne(i, j, x, y, z, y, matrix1, matrix2);
		}
	}
}
/*******************
 * HECHO POR:      *
 * CARLOS FUENTES  *
 * (RAVEN) (LINK)  *
 *******************/

// BAJO LA LICENCIA PÚBLICA GENERAL GNU
// http://www.gnu.org/licenses/gpl.txt
// http://es.wikipedia.org/wiki/GNU_General_Public_License

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <time.h>

#define T_NOM_PROD 20
#define T_NOM_CLI 40
#define MIN_NOM_LEN 4
#define MAX_CANT_VENT 1000
#define true 1
#define false 0

typedef char bool;

// VARIABLES GLOBALES

int  nproductos=0, nclientes=0, nventas=0;

// ESTRUCTURAS PRINCIPALES

struct factura
{
	int codigo;
	int cod_cliente;
	int * productos;
	int * cantidades;
	int n_productos;
	char fecha[32];
	struct factura * siguiente;
};
struct cliente
{
	int codigo;
	char consonante;
	char nombre[T_NOM_CLI];
	struct cliente * siguiente;
};
struct product
{
	int codigo;
	float precio;
	char nombre[T_NOM_PROD];
	bool iva;
	struct product * siguiente;
};

/* *******************************************************
 * Variable para limpiar la pantalla dependiendo del SO. *
 * Para sistemas Unix, Linux, inicializar en "clear".    *
 * Para Windows inicializar en "cls".                    *
 * ***************************************************** */

char *clear = "cls";

// PUNTEROS INICIALES

struct product *p_producto = NULL;
struct product *u_producto = NULL;

struct cliente *p_cliente = NULL;
struct cliente *u_cliente = NULL;

struct factura *p_venta = NULL;
struct factura *u_venta = NULL;

// PROTOTIPOS DE FUNCIONES

void imprimirMenu(int);
void cargarArchivo();
void guardarArchivo();

int venta();
int consulta();
int respaldo();
int nCliente();
int nProducto();

int validarEntero(char*);
int validarDecimal(char*);
void nameCase(char*);
void eliminarEspacios(char*);
int soloLetras (char*);

void listarProductos();
void listarClientes();
void listarVentas();

void imprimirCliente();
void imprimirProducto();
void imprimirVenta();

struct cliente * buscarCliente (int);
struct product * buscarProducto (int);

// MAIN

int main ()
{
	int op;

	cargarArchivo();

	do	{
		char buffer[1];
		imprimirMenu(0);
		printf("Opcion (0-6): ");
		scanf("%s", buffer);

		if (validarEntero(buffer)) op = atoi(buffer);
		system(clear);
		switch (op)
		{
			case 0:
				guardarArchivo();
				printf("\nFin del programa. Presione ENTER para salir.");
				return 0;

			case 1: venta(); break;
			case 2: consulta();	break;
			case 3: respaldo(); break;
			case 4: nProducto();break;
			case 5: nCliente(); break;

			default:
				printf("# Por favor introduzca una opcion valida.\n\n");
				break;
		}

	} while ( op != 0 );

	return 0;
}

void imprimirMenu (int valor)
{
if (valor == 0)
printf("\t\t########## MENU DE PROCESOS ##########\n\
		1: VENTA		2: CONSULTAS\n\
		3: RESPALDO\n\n\
		########## CREAR REGISTROS ###########\n\
		4: PRODUCTO		5: CLIENTE\n\n\
		############## 0: SALIR ##############\n\n");
if (valor == 1)
printf("\t\t########### MENU DE CONSULTAS ###########\n\
		1: VER CLIENTES		2: VER PRODUCTOS\n\
		3: VER VENTAS	\n\n\
		########### BUSCAR POR CODIGO ###########\n\
		4: CLIENTES		5: PRODUCTOS\n\
		6: VENTAS\n\n\
		################ 0: SALIR ###############\n\n");
}

int consulta ()
{
	int op;
	do	{
		char buffer[1];
		imprimirMenu(1);
		printf("Opcion (0-5): ");
		scanf("%s", buffer);
		if (validarEntero(buffer)) op = atoi(buffer);
		system(clear);
		switch (op)
		{
			case 0: break;
			case 1: listarClientes(); break;
			case 2: listarProductos(); break;
			case 3: listarVentas(); break;
			case 4: imprimirCliente();	break;
			case 5: imprimirProducto(); break;
			case 6: imprimirVenta(); break;

			default:
				printf("# Por favor introduzca una opcion valida.\n\n");
				break;
		}
	} while ( op != 0 );
	return 0;
}

void cargarArchivo ()
{
	int i;

	FILE * bd;

	if ( (bd = fopen("sistema.bd", "r+")) == NULL)
	{
		printf("No se ha detectado el archivo \"sistema.bd\". Sera creado.\n\n");
		bd = fopen("sistema.bd", "w+");
		fprintf(bd, "0 0 0 0\n");
	}

	else
	{
		// printf("Cargando...");

		fscanf(bd, "%d %d %d\n", &nproductos, &nclientes, &nventas);

		for (i=0 ; i<nproductos ; i++)
		{
			char nombre_p[T_NOM_PROD];
			struct product *producto;
			producto = (struct product *)malloc(sizeof(struct product));

			fscanf(bd, "%d %c\n%f\n%[^\n]s\n", &producto->codigo, &producto->iva, \
				&producto->precio, nombre_p);
			snprintf(producto->nombre, T_NOM_PROD, "%s", nombre_p);

			if (producto->iva == '1') producto->iva = true;
			else producto->iva = false;

			if ( i==0 )
			{
				p_producto = producto;
				u_producto = producto;
			}
			else
			{
				u_producto->siguiente = producto;
				u_producto = producto;
			}
		}
		for (i=0 ; i<nclientes ; i++)
		{
			int codigo;	char consonante[1], nombre_c[T_NOM_CLI];
			struct cliente *client;
			client = (struct cliente *)malloc(sizeof(struct cliente));

			fscanf(bd, "%s %d\n%[^\n]s\n", consonante, &codigo, nombre_c);
			client->codigo = codigo;
			client->consonante = consonante[0];
			snprintf(client->nombre, T_NOM_CLI, "%s", nombre_c);

			if ( i==0 )
			{
				p_cliente = client;
				u_cliente = client;
			}
			else
			{
				u_cliente->siguiente = client;
				u_cliente = client;
			}
		}

		for (i=0 ; i<nventas ; i++)
		{
			int j;

			struct factura *venta;
			venta = (struct factura *)malloc(sizeof(struct factura));

			fscanf(bd, "%d %d %d\n%[^\n]s\n", &venta->codigo, &venta->cod_cliente, &venta->n_productos, venta->fecha);

			int *productos = (int*)malloc(sizeof(int)*venta->n_productos);
			int *cantidades = (int*)malloc(sizeof(int)*venta->n_productos);

			for (j = 0 ; j < venta->n_productos ; j++)
				fscanf(bd, "%d%*c", &productos[j]);

			for (j = 0 ; j < venta->n_productos ; j++)
				fscanf(bd, "%d%*c", &cantidades[j]);

			venta->productos = productos;
			venta->cantidades = cantidades;

			if ( i==0 )
			{
				p_venta = venta;
				u_venta = venta;
			}
			else
			{
				u_venta->siguiente = venta;
				u_venta = venta;
			}
		}

		// system(clear);
	}

	fclose(bd);
}

void guardarArchivo ()
{
	int i;
	FILE * bd;

	// printf("Guardando cambios... ");
	bd = fopen("sistema.bd", "w+");

	fprintf(bd, "%d %d %d\n", nproductos, nclientes, nventas);

	for (i=0 ; i<nproductos ; i++)
	{
		int iva; struct product *producto;

		if (i == 0)	producto = p_producto;
		else producto = producto->siguiente;

		if (producto->iva == true) iva = 1; else iva = 0;

		fprintf(bd, "%d %d\n%f\n%s\n", producto->codigo, iva, \
			producto->precio, producto->nombre);
	}
	for (i=0 ; i<nclientes ; i++)
	{
		struct cliente *client;

		if (i == 0)
		{
			client = p_cliente;
		}
		else client = client->siguiente;

		fprintf(bd, "%c %d\n%s\n", client->consonante, client->codigo, client->nombre);
	}

	for (i=0 ; i<nventas ; i++)
	{
		int j;

		struct factura *venta;

		if (i == 0)
		{
			venta = p_venta;
		}
		else venta = venta->siguiente;

		fprintf(bd, "%d %d %d\n%s\n", venta->codigo, venta->cod_cliente, venta->n_productos, venta->fecha);

		for (j = 0 ; j < venta->n_productos-1 ; j++)
			fprintf(bd, "%d ", venta->productos[j]);
		fprintf(bd, "%d\n", venta->productos[j]);

		for (j = 0 ; j < venta->n_productos-1 ; j++)
			fprintf(bd, "%d ", venta->cantidades[j]);
		fprintf(bd, "%d\n", venta->cantidades[j]);
	}

	// printf("Listo.\n");
	fclose(bd);
}

int venta ()
{
	char buffer[12] = {0};
	int codigo = 0, cantidad;
	struct product ** productos = (struct product **)malloc(sizeof(struct product *));
	int * cantidades = (int *)malloc(sizeof(int));
	int * listaProductos = (int *)malloc(sizeof(int));
	struct cliente * client = p_cliente;
	struct factura * nventa = (struct factura*)malloc(sizeof(struct factura));

	if ( client == NULL )
	{
		printf("No hay clientes registrados. Presione ENTER para volver.");
		getchar();
		getchar();
		system(clear);
		return 1;
	}

	if ( p_producto == NULL )
	{
		printf("No hay productos registrados. Presione ENTER para volver.");
		getchar();
		getchar();
		system(clear);
		return 1;
	}


	while(1)
	{
		printf("Ingrese CI o RIF del cliente (-1 para volver): \n");
		getchar();
		scanf("%[^\n]s", buffer);

		if (validarEntero(buffer))
		{
			int codigo = atoi(buffer);

			if (codigo == -1)
			{
				system(clear);
				return 1;
			}
			else if (codigo < 1)
			{
				system(clear);
				printf("# Error: CI o RIF invalido.\n\n");
				continue;
			}

			client = buscarCliente(codigo);

			if (client == NULL)
			{
				system(clear);
				printf("# Cliente (%d) no encontrado.\n\n", codigo);
			}
			else
			{
				int cont=0;
				while (cont == 0)
				{
					char temp[2];
					system(clear);

					printf("Cliente: %c-%d. Nombre: %s.\n\n", client->consonante, client->codigo, client->nombre);
					printf("Correcto? (S/N): ");
					getchar();
					scanf("%[^\n]s", temp);

					if (strlen(temp) > 1) continue;

					else switch	(temp[0])
					{
						case 's': case 'S':	cont = 1; break;
						case 'n': case 'N':	system(clear); cont = 2; break;
						default: temp[0] = '\0'; continue;
					}
				}
				if (cont == 1) break;
			}
		}
		else
		{
			system(clear);
			printf("# Error: CI o RIF invalido.\n\n");
		}
	}

	system(clear);
	nventa->n_productos = 0;

	while (1)
	{
		int i;
		float total;

		printf("# Cliente: %c-%d. Nombre: %s.\n\n", client->consonante, client->codigo, client->nombre);

		if (nventa->n_productos > 0)
		{
			total = 0;
			printf("# Lista de Productos:\n\n%10s%10s%20s%20s%10s\n", "Cantidad", "Codigo", "Nombre", "Precio", "IVA");
			for (i = 0; i < nventa->n_productos; i++)
			{
				total += (productos)[i]->precio*cantidades[i];
				printf("%10d%10d%20s%20.2f%10.2f\n", cantidades[i], (productos)[i]->codigo, \
					(productos)[i]->nombre, \
					((productos)[i]->iva == true) ? (productos)[i]->precio-(((productos)[i]->precio*12)/100) : \
					(productos[i]->precio), \
					((productos)[i]->iva == true) ? (((productos)[i]->precio*12)/100) : 0);
			}
			printf("\n%70s\n%70.2f\n\n", "Total", total);
		}

		printf("Inserte codigo del producto (-1 para guardar la venta): \n");
		getchar();
		scanf("%[^\n]s", buffer);

		if (validarEntero(buffer))
		{
			struct product * producto = NULL;
			codigo = atoi(buffer);
			buffer[0] = '\0';

			if (codigo == -1 && nventa->n_productos == 0)
			{
				system(clear);
				printf("# Debe agregar al menos 1 producto antes de guardar.\n\n");
				continue;
			}
			else if (codigo == -1 && nventa->n_productos > 0) break;
			else if (codigo < 1)
			{
				system(clear);
				printf("# Codigo invalido.\n\n");
				continue;
			}

			producto = buscarProducto(codigo);

			if (producto == NULL)
			{
				system(clear);
				printf("# El producto no existe.\n\n");
				continue;
			}
			else
			{
				system(clear);
				while(1)
				{
					cantidad = 0;
					printf("Producto: %d-%s. Precio: %.2f.\n", \
						producto->codigo, producto->nombre, producto->precio);
					printf("Cantidad: ");
					getchar();
					scanf("%[^\n]s", buffer);

					if (validarEntero(buffer))
					{
						cantidad = atoi(buffer);
						buffer[0] = '\0';

						if (cantidad < 1 || cantidad > MAX_CANT_VENT)
						{
							system(clear);
							printf("# Error: Cantidad invalida.\n\n");
							continue;
						}
						else break;
					}
					else
					{
						system(clear);
						printf("# Error: Cantidad invalida.\n\n");
						buffer[0] = '\0';
						continue;
					}
				}

				int cont=0;
				while (cont == 0)
				{
					char temp[2];
					system(clear);

					printf("Producto: %d-%s. Precio Unitario: %.2f. Cantidad: %d.\n\n", \
						producto->codigo, producto->nombre, producto->precio, cantidad);
					printf("Correcto? (S/N): ");
					getchar();
					scanf("%[^\n]s", temp);

					if (strlen(temp) > 1) continue;

					else switch	(temp[0])
					{
						case 's': case 'S':
							system(clear); cont = 1;
							temp[0] = '\0'; break;
						case 'n': case 'N':
							system(clear); cont = 2;
							temp[0] = '\0'; break;
						default: temp[0] = '\0'; break;
					}
				}
				if (cont == 1)
				{
					if (nventa->n_productos == 0)
					{
						cantidades[0] = cantidad;
						(productos)[0] = producto;
						(productos)[nventa->n_productos] = producto;
						listaProductos[nventa->n_productos] = producto->codigo;
						cantidades[nventa->n_productos] = cantidad;
						nventa->n_productos++;
					}
					else
					{
						productos = \
						(struct product **)realloc(productos, sizeof(struct product *)*(nventa->n_productos+1));
						listaProductos = (int *)realloc(listaProductos, sizeof(int)*(nventa->n_productos+1));
						cantidades = (int *)realloc(cantidades, sizeof(int)*(nventa->n_productos+1));

						for (i = 0; i < nventa->n_productos; i++)
						{
							if ((productos)[i]->codigo == producto->codigo)
							{
								cantidades[i] += cantidad;
								i = -1;
								break;
							}
						}

						if (i != -1)
						{
							(productos)[nventa->n_productos] = producto;
							listaProductos[nventa->n_productos] = producto->codigo;
							cantidades[nventa->n_productos] = cantidad;
							nventa->n_productos++;
						}
					}

					cont = 0;
				}
			}
		}
		else
		{
			system(clear);
			printf("# Codigo incorrecto.\n\n");
			continue;
		}

	}

	if ( p_venta == NULL )
	{
		p_venta = nventa;
		u_venta = p_venta;
		p_venta->siguiente = u_venta;
		nventa->codigo = 1;
	}
	else
	{
		nventa->codigo = u_venta->codigo+1;
		u_venta->siguiente = nventa;
		u_venta = nventa;
		u_venta->siguiente = NULL;
	}

	nventa->cod_cliente = client->codigo;
	nventa->productos = listaProductos;
	nventa->cantidades = cantidades;
	nventas++;

	time_t tiempo = time(0);
	struct tm *tlocal = localtime(&tiempo);
	strftime(nventa->fecha,32,"%d/%m/%Y %H:%M",tlocal);

	system(clear);
	printf("# Venta exitosa, codigo %d.\n\n", nventa->codigo);
	getchar();

	return 0;
}

struct cliente * buscarCliente (int codigo)
{
	struct cliente *client = p_cliente;

	if (client == NULL) return NULL;

	while (1)
	{
		if (client->codigo == codigo) return client;
		if (client == u_cliente) break;
		client = client->siguiente;
	}

	if (client->codigo == codigo) return client;
	else return NULL;
}

struct product * buscarProducto (int codigo)
{
	struct product *producto = p_producto;

	if (producto == NULL) return NULL;

	while (1)
	{
		if (producto->codigo == codigo) return producto;
		if (producto == u_producto) break;
		producto = producto->siguiente;
	}

	if (producto->codigo == codigo) return producto;
	else return NULL;
}

struct factura * buscarVenta (int codigo)
{
	struct factura *venta = p_venta;

	if (venta == NULL) return NULL;

	while (1)
	{
		if (venta->codigo == codigo) return venta;
		if (venta == u_venta) break;
		venta = venta->siguiente;
	}

	if (venta->codigo == codigo) return venta;
	else return NULL;
}

int respaldo ()
{
	int cont=0;

	while (cont == 0)
	{
		char temp[2];
		system(clear);

		printf("Desea realizar un respaldo del archivo sistema.bd? (S/N): ");
		getchar();
		scanf("%[^\n]s", temp);

		if (strlen(temp) > 1) continue;

		else switch	(temp[0])
		{
			case 's': case 'S':
				system(clear); cont = 1;
				temp[0] = '\0'; break;
			case 'n': case 'N':
				system(clear); cont = 2;
				temp[0] = '\0'; break;
			default: temp[0] = '\0'; break;
		}
	}

	if (cont == 2) return 1;

	guardarArchivo();

	FILE *source, *target;

	source = fopen("sistema.bd", "r");

	if( source == NULL )
	{
		system(clear);
		printf("# No se pudo abrir el archivo sistema.bd.\n");
		return 1;
	}

	char target_file[128], ch;

	time_t tiempo = time(0);
	struct tm *tlocal = localtime(&tiempo);
	strftime(target_file,128,"respaldo_%d-%m-%Y_%H-%M-%S.bd",tlocal);

	target = fopen(target_file, "w");

	if( target == NULL )
	{
		fclose(source);
		system(clear);
		printf("# No pudo crearse el archivo %s.\n", target_file);
		return 1;
	}

	while( ( ch = fgetc(source) ) != EOF )
		fputc(ch, target);

	system(clear);
	printf("# Respaldo creado satisfactoriamente.\n\n");

	fclose(source);
	fclose(target);
	return 0;
}

int nCliente ()
{
	struct cliente *client;
	client = (struct cliente *)malloc(sizeof(struct cliente));
	char buffer[12] = {0}, temp[2];
	system(clear);

	while (true)
	{
		printf("Introduzca el nombre del cliente (%d caracteres max.):\n", T_NOM_CLI);
		getchar();
		scanf("%[^\n]s", client->nombre);

		eliminarEspacios(client->nombre);

		if ( strlen(client->nombre) < MIN_NOM_LEN )
		{
			system(clear);
			printf("# Nombre invalido\n\n");
		}
		else if ( !soloLetras(client->nombre) )
		{
			system(clear);
			printf("# Nombre invalido\n\n");
		}
		else break;
	}

	nameCase(client->nombre);

	int cont = 0;

	system(clear);
	printf("Nombre: %s\n", client->nombre);

	while (cont == 0)
	{
		printf("Introduzca consonante de CI/RIF [V/E/G/J]: ");
		getchar();
		scanf("%[^\n]s", temp);

		if (strlen(temp) > 1)
		{
			system(clear);
			printf("# Error: Consonante no valida.\n\n");
			printf("Nombre: %s\n", client->nombre);
			continue;
		}

		else switch (temp[0])
		{
			case 'V': case 'E': case 'G': case 'J':
				cont=1; break;

			case 'v': case 'e': case 'g': case 'j':
				temp[0] = toupper(temp[0]); cont=1; break;

			default:
				system(clear);
				printf("# Error: Consonante no valida.\n\n");
				printf("Nombre: %s\n", client->nombre);
				temp[0] = '\0'; break;
		}
	}

	client->consonante = temp[0];
	client->siguiente = NULL;

	system(clear);
	printf("Nombre: %s\n", client->nombre);

	while (1)
	{
		printf("CI/RIF (Solo numeros): %c-", client->consonante);
		getchar();
		scanf("%[^\n]s", buffer);

		if (validarEntero(buffer))
		{
			client->codigo = atoi(buffer);

			if (client->codigo <= 0)
			{
				system(clear);
				printf("# Error: CI o RIF invalido.\n\n");
				printf("Nombre: %s\n", client->nombre);
			}
			else if ( buscarCliente(client->codigo) != NULL )
			{
				system(clear);
				printf("# Error: CI o RIF ya se encuentra registrado.\n\n");
				printf("Nombre: %s\n", client->nombre);
			}
			else break;
		}

		else
		{
			system(clear);
			printf("# Error: CI o RIF invalido.\n\n");
			printf("Nombre: %s\n", client->nombre);
		}
	}

	if ( u_cliente != NULL )
	{
		u_cliente->siguiente = client;
		u_cliente = client;
	}
	else
	{
		p_cliente = client;
		u_cliente = client;
	}

	nclientes++;
	system(clear);

	printf("# Cliente registrado exitosamente. Codigo No. %d.\n\n", client->codigo);

	return client->codigo;
}

int nProducto ()
{
	struct product *producto;
	producto = (struct product *)malloc(sizeof(struct product));
	char buffer[12] = {0};
	system(clear);

	while (true)
	{
		printf("Introduzca el nombre del producto (%d caracteres max.):\n", T_NOM_PROD);
		getchar();
		scanf("%[^\n]s", producto->nombre);

		eliminarEspacios(producto->nombre);

		if ( strlen(producto->nombre) < MIN_NOM_LEN )
		{
			system(clear);
			printf("# Nombre invalido\n\n");
		}
		else if ( !soloLetras(producto->nombre) )
		{
			system(clear);
			printf("# Nombre invalido\n\n");
		}
		else break;
	}

	nameCase(producto->nombre);
	producto->siguiente = NULL;

	system(clear);
	printf("Nombre: %s\n", producto->nombre);

	while (true)
	{
		buffer[0] = '\0';
		printf("Introduzca el precio del producto (Ej. 999.99):\n");
		getchar();
		scanf("%[^\n]s", buffer);

		if (validarDecimal(buffer))
		{
			producto->precio = atof(buffer);
			if (producto->precio <= 0)
			{
				system(clear);
				printf("# Error: Precio invalido.\n\n");
				printf("Nombre: %s\n", producto->nombre);
				continue;
			}
			break;
		}
		else
		{
			system(clear);
			printf("# Error: Precio invalido.\n\n");
			printf("Nombre: %s\n", producto->nombre);
		}
	}

	int cont = 0;

	while (cont == 0)
	{
		char temp[2];

		system(clear);
		printf("Nombre: %s\n", producto->nombre);
		printf("Precio: %.2f\n", producto->precio);

		printf("Posee IVA? (S/N): ");
		scanf("%s", temp);

		if (strlen(temp) > 1) continue;

		else switch	(temp[0])
		{
			case 's': case 'S':
				temp[0] = '\0';
				producto->iva = true;
				cont = 1; break;
			case 'n': case 'N':
				temp[0] = '\0';
				producto->iva = false;
				cont = 1; break;
			default: temp[0] = '\0'; break;
		}
	}

	if ( u_producto != NULL )
	{
		producto->codigo = u_producto->codigo+1;
		u_producto->siguiente = producto;
		u_producto = producto;
	}
	else
	{
		producto->codigo = 1;
		p_producto = producto;
		u_producto = producto;
	}

	nproductos++;

	system(clear);

	printf("# Producto creado exitosamente. Codigo No. %d.\n\n", producto->codigo);

	return producto->codigo;
}

void listarProductos ()
{
	struct product * ptr = p_producto;

	system(clear);

	if ( ptr == NULL )
	{
		printf("No hay productos creados. Presione ENTER para volver.");
		getchar();
		getchar();
		system(clear);
		return;
	}

	printf("Lista de Productos:\n\n");
	printf("======================================================================\n");
	printf("| %10s | %20s | %15s | %12s |\n", "Codigo", "Nombre", "Precio", "IVA");
	printf("======================================================================\n");

	while (1)
	{
		printf("| %10d | %20s | %15.2f | %12.2f |\n", ptr->codigo, ptr->nombre, ptr->precio, \
			(ptr->iva == true) ? (ptr->precio*12)/100 : 0);
		if (ptr == u_producto) break;
		ptr = ptr->siguiente;
	}

	printf("======================================================================\n\n");

	printf("Presione ENTER para volver al menu.");
	getchar(); getchar();
	system(clear);
}

void listarClientes ()
{
	struct cliente * ptr = p_cliente;

	system(clear);

	if ( ptr == NULL )
	{
		printf("No hay clientes registrados. Presione ENTER para volver.");
		getchar();
		getchar();
		system(clear);
		return;
	}

	printf("Lista de Clientes:\n\n");
	printf("=============================================================\n");
	printf("| %14s | %40s |\n", "CI o RIF", "Nombre");
	printf("=============================================================\n");

	while (1)
	{
		printf("| %c-%12d | %40s |\n", ptr->consonante, ptr->codigo, ptr->nombre);
		if (ptr == u_cliente) break;
		ptr = ptr->siguiente;
	}

	printf("=============================================================\n\n");

	printf("Presione ENTER para volver al menu."); getchar(); getchar();
	system(clear);
}

void listarVentas ()
{
	struct factura * venta = p_venta;
	struct cliente * client;

	system(clear);

	if (venta == NULL)
	{
		printf("No se encontro ninguna venta. Presione ENTER para volver.");
		getchar();
		getchar();
		system(clear);
		return;
	}

	printf("Lista de ventas:\n\n");
	printf("===========================================================================\n");
	printf("| %10s | %35s | %20s |\n", "Codigo", "Cliente", "Fecha");
	printf("===========================================================================\n");

	while (1)
	{
		client = buscarCliente(venta->cod_cliente);
		printf("| %10d | %35s | %20s |\n", venta->codigo, (client == NULL) ? "N/A" : client->nombre, venta->fecha);
		if (venta == u_venta) break;
		venta = venta->siguiente;
	}

	printf("===========================================================================\n\n");

	printf("Presione ENTER para volver al menu."); getchar(); getchar();
	system(clear);
}

void eliminarEspacios (char * cadena)
{
	int i = 0;

	while ( cadena[0] == ' ' )
	{
		if ( &(strchr(cadena, ' '))[0] == &cadena[0] )
			for (i=0 ; i<strlen(cadena)-1 ; i++) cadena[i] = cadena[i+1];
		cadena[i] = '\0';
	}
}

void imprimirCliente()
{
	char buffer[8] = {0};
	struct cliente * client;

	while(1)
	{
		printf("Ingrese CI o RIF del cliente (-1 para volver): \n");
		getchar();
		scanf("%[^\n]s", buffer);

		if (validarEntero(buffer))
		{
			int codigo = atoi(buffer);

			if (codigo == -1)
			{
				system(clear);
				return;
			}

			if (codigo < 1)
			{
				system(clear);
				printf("# Error: CI o RIF invalido.\n\n");
			}

			client = buscarCliente(codigo);

			if (client == NULL)
			{
				system(clear);
				printf("# Cliente (%d) no encontrado.\n\n", codigo);
			}
			else
			{
				system(clear);
				printf("=============================================================\n");
				printf("| %14s | %40s |\n", "CI o RIF", "Nombre");
				printf("=============================================================\n");
				printf("| %c-%12d | %40s |\n", client->consonante, client->codigo, client->nombre);
				printf("=============================================================\n\n");
				printf("Presione ENTER para continuar.\n");
				getchar(); getchar();
				system(clear);
				break;
			}
		}
		else
		{
			system(clear);
			printf("# Error: CI o RIF invalido.\n\n");
		}
	}
}

void imprimirProducto()
{
	char buffer[12] = {0};

	while (1)
	{
		int codigo;

		printf("Inserte codigo del producto (-1 para volver): \n");
		getchar();
		scanf("%[^\n]s", buffer);

		if (validarEntero(buffer))
		{
			struct product * producto = NULL;
			codigo = atoi(buffer);
			buffer[0] = '\0';

			if (codigo == -1)
			{
				system(clear);
				break;
			}

			producto = buscarProducto(codigo);

			if (producto == NULL)
			{
				system(clear);
				printf("# El producto no existe.\n\n");
				continue;
			}
			else
			{
				system(clear);
				printf("======================================================================\n");
				printf("| %10s | %20s | %15s | %12s |\n", "Codigo", "Nombre", "Precio", "IVA");
				printf("======================================================================\n");

				printf("| %10d | %20s | %15.2f | %12.2f |\n", producto->codigo, producto->nombre, \
					(producto->iva == true) ? producto->precio - (producto->precio*12)/100 : producto->precio, \
						(producto->iva == true) ? (producto->precio*12)/100 : 0);
				printf("======================================================================\n\n");

				printf("Presione ENTER para volver al menu.");
				getchar(); getchar();
				system(clear);
				break;
			}
		}
		else
		{
			system(clear);
			printf("# Codigo invalido.\n");
			continue;
		}
	}
}

void imprimirVenta()
{
	char buffer[12] = {0};

	while (1)
	{
		int codigo;
		struct cliente * client = NULL;

		printf("Inserte codigo de la venta (-1 para volver): \n");
		getchar();
		scanf("%[^\n]s", buffer);

		if (validarEntero(buffer))
		{
			struct factura * venta = NULL;
			codigo = atoi(buffer);
			buffer[0] = '\0';

			if (codigo == -1)
			{
				system(clear);
				break;
			}

			venta = buscarVenta(codigo);

			if (venta == NULL)
			{
				system(clear);
				printf("# La venta no existe.\n\n");
				continue;
			}
			else
			{
				system(clear);
				printf("===========================================================================\n");
				printf("| %10s | %35s | %20s |\n", "Codigo", "Cliente", "Fecha");
				printf("===========================================================================\n");

				client = buscarCliente(venta->cod_cliente);
				printf("| %10d | %35s | %20s |\n", venta->codigo, (client == NULL) ? "N/A" : client->nombre, venta->fecha);
				printf("===========================================================================\n\n");

				int i;
				float total = 0;
				printf("# Lista de Productos:\n\n%10s%10s%20s%20s%10s\n", "Cantidad", "Codigo", "Nombre", "Precio", "IVA");

				struct product ** productos = (struct product **)malloc(sizeof(struct product *)*(venta->n_productos));

				for (i=0 ; i < venta->n_productos ; i++)
				{
					productos[i] = buscarProducto(venta->productos[i]);
				}

				for (i = 0; i < venta->n_productos; i++)
				{
					total += (productos)[i]->precio*venta->cantidades[i];
					printf("%10d%10d%20s%20.2f%10.2f\n", venta->cantidades[i], (productos)[i]->codigo, \
						(productos)[i]->nombre, \
						((productos)[i]->iva == true) ? (productos)[i]->precio-(((productos)[i]->precio*12)/100) : \
						(productos[i]->precio), \
						((productos)[i]->iva == true) ? (((productos)[i]->precio*12)/100) : 0);
				}
				printf("\n%70s\n%70.2f\n\n", "Total", total);

				printf("Presione ENTER para volver al menu."); getchar(); getchar();
				system(clear);
				break;
			}
		}
		else
		{
			system(clear);
			printf("# Codigo invalido.\n");
			continue;
		}
	}
}

int validarEntero (char *cadena)
{
   int i, valor;
   for(i=0; i < strlen(cadena); i++)
   {
      valor = cadena[ i ] - '0';
      if(valor < 0 || valor > 9)
      {
          if(i==0 && valor==-3) continue;
          return 0;
      }
   }
   return 1;
}

int validarDecimal(char *cadena)
{
   int i, valor;
   int tiene_punto = 0;
   for(i=0; i < strlen(cadena); i++)
   {
      valor = cadena[ i ] - '0';

      if(valor < 0 || valor > 9)
      {
         if(i==0 && valor==-3) continue;
         if(valor==-2 && !tiene_punto)
         {
            tiene_punto=1;
            continue;
         }
         return 0;
      }
   }
   return 1;
}

void nameCase (char *cadena)
{
	int i;

	for (i = 0; i < strlen(cadena); i++)
	{
		if ( i==0 ) cadena[i] = toupper(cadena[i]);
		else if (cadena[i-1] != ' ') cadena[i] = tolower(cadena[i]);
	}
}

int soloLetras (char * cadena)
{
	int i = 0;

	while ( i != strlen(cadena) )
	{
	    if ( ((cadena[i] >= 65) && (cadena[i] <= 90)) \
	    	|| ((cadena[i] >= 97) && (cadena[i] <= 122)) \
	    	|| (cadena[i] == ' '))
	    {
	    	i++;
	    	continue;
	    }
	    else return 0;
	}

	return 1;
}
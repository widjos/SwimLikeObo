#ELimina disco4.disk
rmdisk -path="/home/Mia/disco1.disk"

#Crea un disco de 3000 Kb en la carpeta home
Mkdisk -Size=3000 -unit=K -path="/home/user As/Disco1.disk"


#No es necesario utilizar comillas para la ruta en este caso ya que la ruta no tiene ningún espacio en blanco
Mkdisk -path="/home/user/Disco2.disk" -Unit=K -size=3000

#Se ponen comillas por la carpeta “mis discos” ya que tiene espacios en blanco, se crea si no está no existe
mkdisk -size=5 -unit=M -path="/home/mis discos/Disco3.disk"

#Creará un disco de 10 Mb ya que no hay parámetro unit
Mkdisk -size=10 -path="/home/mis discos/Disco4.disk"


#Elimina Disco4.disk
rmDisk -path="/home/mis discos/Disco4.disk"

mount -path="/home/Disco1.disk" -name=Part1 #id=vda1

mount -path="/home/Disco1.disk" -name=Part2

#Desmonta la partición con id vda1 (En Disco1.dsk)
unmount -id=vda1

#Si no existe, se debe mostrar error
unmount -id=vdx1

#mostrar gerenar reporte 
rep -id=vda1 -Path="/home/user/reports/reporte1.jpg" -name=mbr

#ejecuta el script
exec -path="/home/Desktop/calificacion.sh"


#Crea una partición primaria llamada Particion1 de 300 kb
#con el peor ajuste en el disco Disco1.disk
fdisk -Size=300 -path=/home/Disco1.disk -name=Particion1

#Crea una partición extendida dentro de Disco2 de 300 kb
#Tiene el peor ajuste
fdisk -type=E -path="/home/Disco2.disk" -Unit=K -name=Particion2 -size=300

#Crea una partición lógica con el mejor ajuste, llamada Paricion3,
#de 1 Mb en el Disco3
fdisk -size=1 -type=L -unit=M -fit=BF -path=/misdiscos/Disco3.disk -name="Particion3"

#Intenta crear una partición extendida dentro de Disco2 de 200 kb
#Debería mostrar error ya que ya existe una partición extendida
#dentro de Disco2
fdisk -type=E -path=/home/Disco2.disk -name=Part3 -Unit=K -size=200

#Elimina de forma rápida una partición llamada Particion1
fdisk -delete=fast -name="Particion1" -path=/home/Disco1.disk

#Elimina de forma completa una partición llamada Particion1
fdisk -name=Particion1 -delete=full -path=/home/Disco1.disk

#Quitan 500 Kb de Particion4 en Disco4.dsk
#Ignora los demás parametros (size, delete)
#Se toma como válido el primero que aparezca, en este caso add
fdisk -add=-500 -size=10 -unit=K -path="/home/misdiscos/Disco4.disk" -name="Particion4"

#Agrega 1 Mb a la partición Particion4 del Disco4.dsk
#Se debe validar que haya espacio libre después de la partición
fdisk -add=1 -unit=M -path="/home/mis discos/Disco4.disk"-name="Particion 4"
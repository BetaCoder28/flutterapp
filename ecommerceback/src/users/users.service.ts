import { HttpException, Injectable, HttpStatus } from '@nestjs/common';
import { RegisterUserDto } from 'src/dtos/users/users.dto';
import { PrismaService } from 'src/services/prisma/prisma.service';
import * as bcrypt from 'bcryptjs';

@Injectable()
export class UsersService {
    constructor(private readonly prismaService: PrismaService ) {}

    async registerUser(userData: RegisterUserDto) {
        try{
            // Verificar si el usuario ya existe
            const existingUser = await this.prismaService.user.findUnique({
                where: { email: userData.email },
            });

            if (existingUser) {
                throw new HttpException(
                    'El usuario ya existe con este correo electrónico',
                    HttpStatus.CONFLICT,
                );
            }

            // Hash de la contraseña
            const hashedPassword = await bcrypt.hash(userData.password, 10);

            // Crear el usuario
            const user = await this.prismaService.user.create({
                data: {
                    ...userData,
                    password: hashedPassword,
                },
            });

            // Remover la contraseña del objeto de respuesta
            const { password, ...userWithoutPassword } = user;

            return {
                message: "Usuario registrado correctamente",
                user: userWithoutPassword
            }
        }
        catch(error){
            if (error instanceof HttpException) {
                throw error;
            }
            throw new HttpException('Error al registrar usuario', HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    async getAllUsers() {
        try {
            const users = await this.prismaService.user.findMany({
                select: {
                    id: true,
                    name: true,
                    lastname: true,
                    email: true,
                    phone: true,
                    image: true,
                    notification_token: true,
                    created_at: true,
                    updated_at: true
                }
            });
            return users;
        } catch (error) {
            throw new HttpException('Error al obtener usuarios', 500);
        }
    }

    async getUserById(id: number) {
        try {
            const user = await this.prismaService.user.findUnique({
                where: { id },
                select: {
                    id: true,
                    name: true,
                    lastname: true,
                    email: true,
                    phone: true,
                    image: true,
                    notification_token: true,
                    created_at: true,
                    updated_at: true
                }
            });
            
            if (!user) {
                throw new HttpException('Usuario no encontrado', 404);
            }
            
            return user;
        } catch (error) {
            if (error instanceof HttpException) {
                throw error;
            }
            throw new HttpException('Error al obtener usuario', 500);
        }
    }
}

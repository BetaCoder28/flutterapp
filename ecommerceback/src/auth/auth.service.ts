import { Injectable, HttpException, HttpStatus } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { PrismaService } from '../services/prisma/prisma.service';
import { LoginUserDto } from '../dtos/users/users.dto';
import * as bcrypt from 'bcryptjs';

@Injectable()
export class AuthService {
  constructor(
    private readonly prismaService: PrismaService,
    private readonly jwtService: JwtService,
  ) {}

  async login(loginData: LoginUserDto) {
    try {
      // Buscar el usuario por email
      const user = await this.prismaService.user.findUnique({
        where: { email: loginData.email },
      });

      if (!user) {
        throw new HttpException(
          'Credenciales inválidas',
          HttpStatus.UNAUTHORIZED,
        );
      }

      // Verificar la contraseña
      const isPasswordValid = await bcrypt.compare(loginData.password, user.password);

      if (!isPasswordValid) {
        throw new HttpException(
          'Credenciales inválidas',
          HttpStatus.UNAUTHORIZED,
        );
      }

      // Generar JWT
      const payload = { email: user.email, sub: user.id };
      const token = this.jwtService.sign(payload);

      // Remover la contraseña del objeto de respuesta
      const { password, ...userWithoutPassword } = user;

      return {
        message: 'Inicio de sesión exitoso',
        user: userWithoutPassword,
        token,
      };
    } catch (error) {
      if (error instanceof HttpException) {
        throw error;
      }
      throw new HttpException(
        'Error interno del servidor',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  async validateUser(email: string, password: string): Promise<any> {
    const user = await this.prismaService.user.findUnique({
      where: { email },
    });

    if (user && await bcrypt.compare(password, user.password)) {
      const { password, ...result } = user;
      return result;
    }
    return null;
  }
}

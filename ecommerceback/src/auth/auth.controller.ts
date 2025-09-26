import { Controller, Post, Body, HttpCode, HttpStatus } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiBearerAuth } from '@nestjs/swagger';
import { AuthService } from './auth.service';
import { LoginUserDto } from '../dtos/users/users.dto';

@ApiTags('auth')
@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('login')
  @HttpCode(HttpStatus.OK)
  @ApiOperation({ 
    summary: 'Iniciar sesión',
    description: 'Autentica a un usuario con email y contraseña, devuelve un JWT token'
  })
  @ApiResponse({ 
    status: 200, 
    description: 'Inicio de sesión exitoso',
    schema: {
      type: 'object',
      properties: {
        message: { type: 'string', example: 'Inicio de sesión exitoso' },
        user: {
          type: 'object',
          properties: {
            id: { type: 'number', example: 1 },
            name: { type: 'string', example: 'Juan' },
            lastname: { type: 'string', example: 'Pérez' },
            email: { type: 'string', example: 'juan.perez@email.com' },
            phone: { type: 'string', example: '+1234567890' },
            image: { type: 'string', example: 'https://example.com/image.jpg', nullable: true },
            notification_token: { type: 'string', example: 'fcm_token_here' },
            created_at: { type: 'string', format: 'date-time' },
            updated_at: { type: 'string', format: 'date-time' }
          }
        },
        token: { type: 'string', example: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...' }
      }
    }
  })
  @ApiResponse({ 
    status: 401, 
    description: 'Credenciales inválidas',
    schema: {
      type: 'object',
      properties: {
        statusCode: { type: 'number', example: 401 },
        message: { type: 'string', example: 'Credenciales inválidas' },
        error: { type: 'string', example: 'Unauthorized' }
      }
    }
  })
  @ApiResponse({ 
    status: 400, 
    description: 'Datos de entrada inválidos',
    schema: {
      type: 'object',
      properties: {
        statusCode: { type: 'number', example: 400 },
        message: { type: 'array', items: { type: 'string' }, example: ['Debe proporcionar un correo electrónico válido'] },
        error: { type: 'string', example: 'Bad Request' }
      }
    }
  })
  async login(@Body() loginUserDto: LoginUserDto) {
    return this.authService.login(loginUserDto);
  }
}

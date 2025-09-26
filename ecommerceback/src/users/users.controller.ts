import { Controller, Get, Post, Body, Param, ParseIntPipe } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse, ApiParam, ApiBearerAuth } from '@nestjs/swagger';
import { UsersService } from './users.service';
import { RegisterUserDto } from '../dtos/users/users.dto';

@ApiTags('users')
@Controller('users')
export class UsersController {
    constructor(private readonly userService: UsersService){}

    @Post('register')
    @ApiOperation({ 
        summary: 'Registrar un nuevo usuario',
        description: 'Crea una nueva cuenta de usuario con email y contraseña hasheada'
    })
    @ApiResponse({ 
        status: 201, 
        description: 'Usuario registrado exitosamente',
        schema: {
            type: 'object',
            properties: {
                message: { type: 'string', example: 'Usuario registrado correctamente' },
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
                }
            }
        }
    })
    @ApiResponse({ 
        status: 409, 
        description: 'El usuario ya existe',
        schema: {
            type: 'object',
            properties: {
                statusCode: { type: 'number', example: 409 },
                message: { type: 'string', example: 'El usuario ya existe con este correo electrónico' },
                error: { type: 'string', example: 'Conflict' }
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
                message: { type: 'array', items: { type: 'string' }, example: ['El nombre debe ser una cadena de texto'] },
                error: { type: 'string', example: 'Bad Request' }
            }
        }
    })
    async registerUser(@Body() registerUserDto: RegisterUserDto) {
        return this.userService.registerUser(registerUserDto);
    }

    @Get()
    @ApiOperation({ 
        summary: 'Obtener todos los usuarios',
        description: 'Retorna una lista de todos los usuarios registrados (sin contraseñas)'
    })
    @ApiResponse({ 
        status: 200, 
        description: 'Lista de usuarios obtenida exitosamente',
        schema: {
            type: 'array',
            items: {
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
            }
        }
    })
    async getAllUsers() {
        return this.userService.getAllUsers();
    }

    @Get(':id')
    @ApiOperation({ 
        summary: 'Obtener usuario por ID',
        description: 'Retorna los datos de un usuario específico por su ID'
    })
    @ApiParam({ 
        name: 'id', 
        description: 'ID del usuario',
        type: 'number',
        example: 1
    })
    @ApiResponse({ 
        status: 200, 
        description: 'Usuario encontrado exitosamente',
        schema: {
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
        }
    })
    @ApiResponse({ 
        status: 404, 
        description: 'Usuario no encontrado',
        schema: {
            type: 'object',
            properties: {
                statusCode: { type: 'number', example: 404 },
                message: { type: 'string', example: 'Usuario no encontrado' },
                error: { type: 'string', example: 'Not Found' }
            }
        }
    })
    async getUserById(@Param('id', ParseIntPipe) id: number) {
        return this.userService.getUserById(id);
    }
}

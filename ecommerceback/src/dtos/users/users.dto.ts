import { IsString, IsEmail, IsOptional, MinLength, MaxLength, Matches } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';

export class RegisterUserDto {
    @ApiProperty({ 
        description: 'Nombre del usuario',
        example: 'Juan',
        minLength: 2,
        maxLength: 50
    })
    @IsString({ message: 'El nombre debe ser una cadena de texto' })
    @MinLength(2, { message: 'El nombre debe tener al menos 2 caracteres' })
    @MaxLength(50, { message: 'El nombre no puede tener más de 50 caracteres' })
    name: string;

    @ApiProperty({ 
        description: 'Apellido del usuario',
        example: 'Pérez',
        minLength: 2,
        maxLength: 50
    })
    @IsString({ message: 'El apellido debe ser una cadena de texto' })
    @MinLength(2, { message: 'El apellido debe tener al menos 2 caracteres' })
    @MaxLength(50, { message: 'El apellido no puede tener más de 50 caracteres' })
    lastname: string;

    @ApiProperty({ 
        description: 'Correo electrónico del usuario',
        example: 'juan.perez@email.com'
    })
    @IsEmail({}, { message: 'Debe proporcionar un correo electrónico válido' })
    email: string;

    @ApiProperty({ 
        description: 'Número de teléfono del usuario',
        example: '+1234567890'
    })
    @IsString({ message: 'El teléfono debe ser una cadena de texto' })
    @Matches(/^\+?[1-9]\d{1,14}$/, { message: 'Debe proporcionar un número de teléfono válido' })
    phone: string;

    @ApiProperty({ 
        description: 'URL de la imagen del usuario (opcional)',
        example: 'https://example.com/image.jpg',
        required: false
    })
    @IsOptional()
    @IsString({ message: 'La imagen debe ser una cadena de texto' })
    image?: string;

    @ApiProperty({ 
        description: 'Contraseña del usuario',
        example: 'miPassword123',
        minLength: 6
    })
    @IsString({ message: 'La contraseña debe ser una cadena de texto' })
    @MinLength(6, { message: 'La contraseña debe tener al menos 6 caracteres' })
    @Matches(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/, { 
        message: 'La contraseña debe contener al menos una letra minúscula, una mayúscula y un número' 
    })
    password: string;

    @ApiProperty({ 
        description: 'Token de notificación para dispositivos móviles',
        example: 'fcm_token_here'
    })
    @IsString({ message: 'El token de notificación debe ser una cadena de texto' })
    notification_token: string;
}

export class LoginUserDto {
    @ApiProperty({ 
        description: 'Correo electrónico del usuario',
        example: 'juan.perez@email.com'
    })
    @IsEmail({}, { message: 'Debe proporcionar un correo electrónico válido' })
    email: string;

    @ApiProperty({ 
        description: 'Contraseña del usuario',
        example: 'miPassword123'
    })
    @IsString({ message: 'La contraseña debe ser una cadena de texto' })
    password: string;
}

export class UpdateUserDto {
    @ApiProperty({ 
        description: 'Nombre del usuario',
        example: 'Juan',
        minLength: 2,
        maxLength: 50,
        required: false
    })
    @IsOptional()
    @IsString({ message: 'El nombre debe ser una cadena de texto' })
    @MinLength(2, { message: 'El nombre debe tener al menos 2 caracteres' })
    @MaxLength(50, { message: 'El nombre no puede tener más de 50 caracteres' })
    name?: string;

    @ApiProperty({ 
        description: 'Apellido del usuario',
        example: 'Pérez',
        minLength: 2,
        maxLength: 50,
        required: false
    })
    @IsOptional()
    @IsString({ message: 'El apellido debe ser una cadena de texto' })
    @MinLength(2, { message: 'El apellido debe tener al menos 2 caracteres' })
    @MaxLength(50, { message: 'El apellido no puede tener más de 50 caracteres' })
    lastname?: string;

    @ApiProperty({ 
        description: 'Correo electrónico del usuario',
        example: 'juan.perez@email.com',
        required: false
    })
    @IsOptional()
    @IsEmail({}, { message: 'Debe proporcionar un correo electrónico válido' })
    email?: string;

    @ApiProperty({ 
        description: 'Número de teléfono del usuario',
        example: '+1234567890',
        required: false
    })
    @IsOptional()
    @IsString({ message: 'El teléfono debe ser una cadena de texto' })
    @Matches(/^\+?[1-9]\d{1,14}$/, { message: 'Debe proporcionar un número de teléfono válido' })
    phone?: string;

    @ApiProperty({ 
        description: 'URL de la imagen del usuario (opcional)',
        example: 'https://example.com/image.jpg',
        required: false
    })
    @IsOptional()
    @IsString({ message: 'La imagen debe ser una cadena de texto' })
    image?: string;

    @ApiProperty({ 
        description: 'Token de notificación para dispositivos móviles',
        example: 'fcm_token_here',
        required: false
    })
    @IsOptional()
    @IsString({ message: 'El token de notificación debe ser una cadena de texto' })
    notification_token?: string;
}
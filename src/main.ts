import { NestFactory } from '@nestjs/core';
import {
  ExpressAdapter,
  NestExpressApplication,
} from '@nestjs/platform-express';
import { AppModule } from './app.module';
import { ConfigService } from '@nestjs/config';
import { Logger, ValidationPipe } from '@nestjs/common';
import * as morgan from 'morgan';
import { setupSwagger } from './swagger';

async function bootstrap() {
  const app = await NestFactory.create<NestExpressApplication>(
    AppModule,
    new ExpressAdapter(),
    { cors: true },
  );

  const configService = app.get<ConfigService>(ConfigService);

  app.useGlobalPipes(
    new ValidationPipe({
      transform: true,
    }),
  );

  morgan.token('id', (req: any) => (req.user ? req.user.id : 'null'));
  morgan.token('body', (req: any, res: any) =>
      req.method === 'POST' && res.statusCode >= 400
          ? JSON.stringify(req.body)
          : 'null',
  );
  app.use(
      morgan(
          ':date[clf] :id :method :url :status body - :body :response-time',
      ),
  );

  setupSwagger(app);

  const port = Number(configService.get('PORT')) || 3000;
  const host = configService.get('HOST');
  await app.listen(port, host);
  Logger.log(`Listening at ${await app.getUrl()}/docs`);
}

bootstrap();

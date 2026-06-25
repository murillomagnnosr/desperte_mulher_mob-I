import { createApp } from './app.js';
import { env } from './config/env.js';

const app = createApp();

app.listen(env.port, () => {
  console.log(
    `🚀 API Desperte Mulher em http://localhost:${env.port}/api/v1 (${env.nodeEnv})`,
  );
});

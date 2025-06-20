FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY src/package*.json ./

# Install dependencies
RUN npm install --only=production

# Copy application code
COPY src/ .

# Create non-root user
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nodejs -u 1001
USER nodejs

EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1

CMD ["npm", "start"]
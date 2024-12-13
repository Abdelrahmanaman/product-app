FROM oven/bun:latest AS builder
    
WORKDIR /app

#Copy package files
COPY  package.json bun.lockb  ./

#Install dependencies
RUN bun install

#Copy the rest of the files
COPY . .

#Build the application
RUN bun run build

#Production stage
FROM oven/bun:latest

#Copy the build artifact from the builder stage
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/bun.lockb ./bun.lockb


#Install production dependencies
RUN bun install --production


#Expose port for the frontend to run on 
EXPOSE 3000 

CMD ["bun", "start"]
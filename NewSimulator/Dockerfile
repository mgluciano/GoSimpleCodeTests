FROM golang:1.14


WORKDIR /go/src/kiosk_simulator
COPY . .


ARG Stage_DB_W_Host
ARG Stage_DB_User
ARG Stage_DB_Password

ARG DB_R_Host
ARG DB_User
ARG DB_Password
ARG DB_Name
ARG DB_Port
ARG Store_ID



RUN echo ${DB_R_Host}
RUN echo ${Stage_DB_W_Host}


RUN go get -d -v ./...
RUN go install -v ./...


ENTRYPOINT ["kiosk_simulator"]

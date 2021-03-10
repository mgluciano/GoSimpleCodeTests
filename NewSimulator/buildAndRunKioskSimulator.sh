echo "Rebuilding Kiosk_Simulatror ">>kiosk_simulator.log
docker build -t kiosk_simulator .
docker run --env-file .env -it kiosk_simulator |tee -a kiosk_simulator.log

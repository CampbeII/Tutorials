extern "C"
{
    void startx();
    void led(byte);
}
void setup() {
    startx();    
}
void loop() {
    led(1);
    led(0);
}

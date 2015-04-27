





typedef int (*fun_callback)(void*buff,int len,int w,int h);
int initClient(int* handler,char *url,fun_callback callback,int isWifi);

void destroyClient(int *handler);



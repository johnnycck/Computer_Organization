#include<iostream>
#include<string>
#include<iomanip>
#include<queue>
using namespace std;

int MissCnt;
int HitCnt;
int Block_Address;
int Block_Size;     // Bytes
int Page_Num;
int Index;
int Tag;
int Label;
int ReadCnt;
int WriteCnt;
int BytesToMem;
int BytesFromMem;
string Replace_Policy;
queue<int>* CacheQueue;
int** CacheLRU;

typedef struct _cache{
    int Valid;
    int Dirty;
    int Tag;
    string Data;
}   Cache;

Cache** MyCache;

void Direct_Mapped(){
    bool HitFlag;
    Cache &MapCache = MyCache[Index][0];

    // 先判斷是否 Hit

    // Miss
    if(MapCache.Valid == 0){
        MapCache.Valid = 1;
        MapCache.Tag = Tag;
        HitFlag = false;
        MissCnt++;
    }
    // Miss
    else if(MapCache.Tag != Tag){
        MapCache.Tag = Tag;
        HitFlag = false;
        MissCnt++;
    }
    // Hit
    else{
        HitFlag = true;
        HitCnt++;
    }
    switch(Label){
        // Data Read
        case 0: 
            ReadCnt++;
            //Hit
            if(HitFlag == true){
                // Return Data
            }
            // Miss
            else{
                if(MapCache.Dirty == 1){
                    BytesToMem += Block_Size;   //  If Dirty, Write its previous data back to the lower memory
                    BytesFromMem += Block_Size; //  Read data from lower memory inot the cache block
                }
                else{
                    BytesFromMem += Block_Size; //  Read data from lower memory inot the cache block
                }
                MapCache.Dirty = 0;
            }
            break;

        // Data Write
        case 1: 
            WriteCnt++;
            // Hit
            if(HitFlag == true){
                // Write the new data into the cache block
            }
            // Miss
            else{
                if(MapCache.Dirty == 1){
                    BytesToMem += Block_Size;   //  If Dirty, Write its previous data back to the lower memory
                    BytesFromMem += Block_Size; //  Read data from lower memory inot the cache block
                }
                else{
                    BytesFromMem += Block_Size; //  Read data from lower memory inot the cache block
                }
            }
            MapCache.Dirty = 1;
            break;

        // Instruction
        case 2:
            //cout << "Instruction" << endl;
            if(HitFlag == false){
                if(MapCache.Dirty == 1){
                    BytesToMem += Block_Size;   //  If Dirty, Write its previous data back to the lower memory
                    BytesFromMem += Block_Size; //  Read data from lower memory inot the cache block
                }
                else{
                    BytesFromMem += Block_Size; //  Read data from lower memory inot the cache block
                }
                MapCache.Dirty = 0;
            }
            break;
    }
}
void NWay_Associativity(){
    bool HitFlag;
    int i;
    Cache* &MapCache = MyCache[Index];
    int* &LRU = CacheLRU[Index];
    
    for(i=0;i<Page_Num;i++){
        if(MapCache[i].Valid == 0 || Tag != MapCache[i].Tag)
            continue; 
        //Hit
        else{
            HitFlag = true;
            HitCnt++;
            break;
        }
    }
    // Hit LRU Calculate
    for(int j=0;j<Page_Num;j++)
        if(MapCache[j].Valid != 0)
            LRU[j]++;
    LRU[i] = 0;
        
    int Replace_index = i;
    // Miss
    if(i==Page_Num){
        HitFlag = false;
        MissCnt++;
        // 找空位
        for(i=0;i<Page_Num;i++){
            // 找到空位
            if(MapCache[i].Valid == 0 && MapCache[i].Tag != Tag){
                MapCache[i].Valid = 1;
                MapCache[i].Tag = Tag;
                CacheQueue[Index].push(Tag);
                LRU[i] = 0;
                Replace_index = i;
                break;
            }
            else{
                LRU[i]++;
            }
        }
        // 沒有空位了
        // Replacement
        if(i==Page_Num){
            //FIFO
            if(Replace_Policy == "FIFO"){
                int Replace = CacheQueue[Index].front();
                CacheQueue[Index].pop();
                for(i=0;i<Page_Num;i++){
                    // find the Replace Target
                    if(MapCache[i].Tag == Replace){
                        MapCache[i].Tag = Tag;
                        CacheQueue[Index].push(Tag);
                        Replace_index = i;
                        break;
                    }
                }
            }
            // LRU
            else{
                int MAX_Idle = 0;
                for(i=0;i<Page_Num;i++)
                    if(LRU[i] > MAX_Idle){
                        MAX_Idle = LRU[i];
                        Replace_index = i;
                    }
                MapCache[Replace_index].Tag = Tag;
                for(i=0;i<Page_Num;i++)
                    LRU[i]++;
                LRU[Replace_index] = 0;
            }
        }
    }
    //cout << Replace_index << endl;
    switch(Label){
        // Data Read
        case 0:
            ReadCnt++;
            //Hit
            if(HitFlag == true){
                // Return Data
            }
            // Miss
            else{
                if(MapCache[Replace_index].Dirty == 1){
                    BytesToMem += Block_Size;   //  If Dirty, Write its previous data back to the lower memory
                    BytesFromMem += Block_Size; //  Read data from lower memory inot the cache block
                }
                else{
                    BytesFromMem += Block_Size; //  Read data from lower memory inot the cache block
                }
                MapCache[Replace_index].Dirty = 0;
            }
            break;

        // Data Write
        case 1:
            WriteCnt++;
            // Hit
            if(HitFlag == true){
                // Write the new data into the cache block
            }
            // Miss
            else{
                if(MapCache[Replace_index].Dirty == 1){
                    BytesToMem += Block_Size;   //  If Dirty, Write its previous data back to the lower memory
                    BytesFromMem += Block_Size; //  Read data from lower memory inot the cache block
                }
                else{
                    BytesFromMem += Block_Size; //  Read data from lower memory inot the cache block
                }
            }
            MapCache[Replace_index].Dirty = 1;
            break;
        // Instruction
        case 2:
            if(HitFlag == false){
                if(MapCache[Replace_index].Dirty == 1){
                    BytesToMem += Block_Size;   //  If Dirty, Write its previous data back to the lower memory
                    BytesFromMem += Block_Size; //  Read data from lower memory inot the cache block
                }
                else{
                    BytesFromMem += Block_Size; //  Read data from lower memory inot the cache block
                }
                MapCache[Replace_index].Dirty = 0;
            }
            break;
    }
}

int main(int argc, char const *argv[]){
    if(argc != 6){
        cout << "Error! input syntax error" << endl;
        return 0;
    }
    int Cache_Size;             // KB
    int Set_Num;                //#Set in Cache
    char Associativity_Type;    // N-Way, 1,2,4,8,f
    string InputFileName;

    Cache_Size = atoi(argv[1]);
    Block_Size = atoi(argv[2]);
    Associativity_Type = argv[3][0];
    Replace_Policy = argv[4];
    InputFileName = argv[5];

    switch(Associativity_Type){
            // 1-Way Associativity  (Direct-mapped)
            case '1':
                Page_Num = 1;
                Set_Num = (Cache_Size * 1024) / Block_Size;
                break;

            // 2-Way Associativity
            case '2':
                Page_Num = 2;
                Set_Num = ((Cache_Size * 1024) / Block_Size) / 2; 
                break;

            // 4-Way Associativity
            case '4':
                Page_Num = 4;
                Set_Num = ((Cache_Size * 1024) / Block_Size) / 4; 
                break;
            
            // 8-Way Associativity
            case '8':
                Page_Num = 8;
                Set_Num = ((Cache_Size * 1024) / Block_Size) / 8; 
                break;

            //Fully Associativity
            case 'f':
                Page_Num = (Cache_Size * 1024) / Block_Size ;
                Set_Num = 1; 
                break;
        }
    CacheQueue = new queue<int>[Set_Num];
    MyCache = new Cache*[Set_Num];
    CacheLRU = new int*[Set_Num];
    

    for(int i=0;i<Set_Num;i++){
        MyCache[i] = new Cache[Page_Num];
        CacheLRU[i] = new int[Page_Num];
    }
        
    for(int i=0; i<Set_Num;i++)
        for(int j=0; j<Page_Num;j++){
            MyCache[i][j].Tag = 0;
            MyCache[i][j].Valid = 0;
            MyCache[i][j].Dirty = 0;
            CacheLRU[i][j] = 0;
        }
    
    FILE* fp;
    fp = fopen(InputFileName.c_str(), "r");
    int Demand_Fetch = 0;
    unsigned int Address;
    MissCnt = 0;
    HitCnt = 0;
    ReadCnt = 0;
    WriteCnt = 0;
    BytesToMem = 0;
    BytesFromMem = 0;
    int n = 10;
    // !feof(fp)
    while(!feof(fp)){
        fscanf(fp, "%d", &Label);
        fscanf(fp, "%x", &Address);
        //printf("Address:%d\n",Address); 
        Block_Address = Address / Block_Size;
        Index = Block_Address % Set_Num;
        Tag = Block_Address / Set_Num ;
        //printf("Block Addr:%d\n",Block_Address); 
        //cout << "Tag:" << Tag << endl;
        //cout << "Index:" << Index << endl;
        
        if(Associativity_Type == '1')
            Direct_Mapped();
        else
            NWay_Associativity();
        Demand_Fetch++;
    }
    for(int i=0;i<Set_Num;i++)
        for(int j=0;j<Page_Num;j++)
            if(MyCache[i][j].Dirty == 1)
                BytesToMem+=Block_Size; 
    cout << "Input File = " << InputFileName << endl;
    cout << "Cache Size = " << Cache_Size << " KB" << endl;
    cout << "Block Size = " << Block_Size << " Bytes" << endl;
    cout << "Set Num = " << Set_Num << endl;
    cout << "Page Num = " << Page_Num << endl;
    cout << "Replace Policy = " << Replace_Policy << endl;
    cout << "Demand Fetch = " <<  Demand_Fetch << endl;
    cout << "Cache Hit = " << HitCnt << endl;
    cout << "Cache Miss = " << MissCnt << endl;
    cout << "Miss Rate = " << fixed <<  setprecision(4) << (double)MissCnt / (double)Demand_Fetch << endl;
    cout << "Read Data = " << ReadCnt << endl;
    cout << "Write Data = " << WriteCnt << endl;
    cout << "Bytes from Memory = " << BytesFromMem << endl;
    cout << "Bytes to Memory = " << BytesToMem << endl;
    return 0;
}
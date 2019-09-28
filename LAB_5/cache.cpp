#include <bits/stdc++.h>
using namespace std;
typedef struct cache {
    int Tag;
    int dirty;
} Cache;
Cache** Nway_Cache;
int ** LRU_Cache;
queue<int>* QueueCache;
int cache_size, block_size, cache_hit, cache_miss, read_data, write_data, byte_from_mem, byte_to_mem;
void put_direct_data(Cache block[], int label, int addr, int num_block) {
    addr /= block_size;
    int n = addr % num_block;
    
    if( label == 0 ) {
        if(addr==block[n].Tag)  cache_hit++;
        else {
            block[n].Tag = addr;
            if(block[n].dirty == 0) byte_from_mem += block_size;
            else {
                byte_to_mem += block_size;
                byte_from_mem += block_size;
            }
            block[n].dirty = 0;
            cache_miss++;
        }
        read_data++;
    }
    if( label == 1 ) {
        if(addr==block[n].Tag) cache_hit++;
        else {
            block[n].Tag = addr;
            if(block[n].dirty == 0) byte_from_mem += block_size;
            else {
                byte_to_mem += block_size;
                byte_from_mem += block_size;
            }
            cache_miss++;
        }
        block[n].dirty = 1;
        write_data++;
    }
    if( label == 2) {
        if(addr==block[n].Tag) cache_hit++;
        else {
            block[n].Tag = addr;
            if(block[n].dirty == 0) byte_from_mem += block_size;
            else   {
                byte_to_mem += block_size;
                byte_from_mem += block_size;
            }
            block[n].dirty = 0;
            cache_miss++;
        }
        
    }
}
void put_nway_data(int label, int addr, int row, int column, int policy) {
    addr /= block_size;
    int n = addr % column;
    addr /= column;
    int find = 0, space=0;
    int i, index;
    if( label == 0 ) {
        for(i=0; i<row; i++){
            if(Nway_Cache[n][i].Tag == addr) {
                cache_hit++;
                find = 1;
                break;
            }
        }
        //if( find==1 ) {
            for(int j=0; j<row; j++) {
                if(Nway_Cache[n][j].Tag != 0) {    
                    LRU_Cache[n][j]++;
                }
            }
      //  }
        LRU_Cache[n][i] = 0;
        if( find==0 ) {
            cache_miss++;
            for(i=0; i<row; i++) {
                if(Nway_Cache[n][i].Tag == 0) {
                    space = 1;
                    index = i;
                    break;
                }
                else LRU_Cache[n][i] ++;
            }
            if( space == 1 ) {
                Nway_Cache[n][index].Tag = addr;
                LRU_Cache[n][index] = 0;
                QueueCache[n].push(addr); 
                if(Nway_Cache[n][index].dirty==1) {
                    byte_to_mem += block_size;
                    byte_from_mem += block_size;
                }
                else byte_from_mem += block_size;
                Nway_Cache[n][index].dirty = 0;
            }
            else if( space==0 && policy==0 ) {                           //FIFO
                int out = QueueCache[n].front();
                QueueCache[n].pop();
                
                for(i=0; i<row; i++) {
                    if(Nway_Cache[n][i].Tag==out) {
                        Nway_Cache[n][i].Tag = addr;
                        QueueCache[n].push(addr);
                        break;
                    }
                }
                if(Nway_Cache[n][i].dirty==1) {
                    byte_to_mem += block_size;
                    byte_from_mem += block_size;
                }
                else byte_from_mem += block_size;
                Nway_Cache[n][i].dirty = 0;
            }  
            else if( space==0 && policy==1 ) {                           //LRU
                int max=0;
                for(i=0; i<row; i++) {
                    if(LRU_Cache[n][i] > max) {
                        max = LRU_Cache[n][i];
                        index = i;
                    }
                }
                i = index;
                Nway_Cache[n][i].Tag = addr;
                for(i=0; i<row; i++) {
                    LRU_Cache[n][i]++;
                }
                LRU_Cache[n][index] = 0;
                if(Nway_Cache[n][index].dirty==1) {
                    byte_to_mem += block_size;
                    byte_from_mem += block_size;
                }
                else byte_from_mem += block_size;
                Nway_Cache[n][index].dirty = 0;
            }  
          
        }  
        read_data++;      
    }

    if( label == 1 ) {
        for(i=0; i<row; i++){
            if(Nway_Cache[n][i].Tag == addr) {
                cache_hit++;
                find = 1;
                break;
            }
        }
        if( find==1 ) {
            for(int j=0; j<row; j++) {
                if(Nway_Cache[n][j].Tag != 0) {    
                    LRU_Cache[n][j]++;
                }
            }
            Nway_Cache[n][i].dirty = 1;
        }

        LRU_Cache[n][i] = 0;
        if( find==0 ) {
            cache_miss++;
            for(i=0; i<row; i++) {
                if(Nway_Cache[n][i].Tag == 0) {
                    space = 1;
                    index = i;
                    break;
                }
                else LRU_Cache[n][i] ++;
            }
            if( space == 1 ) {
                Nway_Cache[n][index].Tag = addr;
                LRU_Cache[n][index] = 0;
                QueueCache[n].push(addr); 
                if(Nway_Cache[n][index].dirty==1) {
                    byte_to_mem += block_size;
                    byte_from_mem += block_size;
                }
                else byte_from_mem += block_size;
                Nway_Cache[n][index].dirty = 1;
            }
            else if( space==0 && policy==0 ) {                           //FIFO
                int out = QueueCache[n].front();
                QueueCache[n].pop();
                
                for(i=0; i<row; i++) {
                    if(Nway_Cache[n][i].Tag==out) {
                        Nway_Cache[n][i].Tag = addr;
                        QueueCache[n].push(addr);
                        break;
                    }
                }
                if(Nway_Cache[n][i].dirty==1) {
                    byte_to_mem += block_size;
                    byte_from_mem += block_size;
                }
                else byte_from_mem += block_size;
                Nway_Cache[n][i].dirty = 1;
            }  
            else if( space==0 && policy==1 ) {                           //LRU
                int max=0,index=0;
                for(i=0; i<row; i++) {
                    if(LRU_Cache[n][i] > max) {
                        max = LRU_Cache[n][i];
                        index = i;
                    }
                }
                i = index;
                Nway_Cache[n][i].Tag = addr;
                for(i=0; i<row; i++) {
                    LRU_Cache[n][i]++;
                }
                LRU_Cache[n][index] = 0;
                if(Nway_Cache[n][index].dirty==1) {
                    byte_to_mem += block_size;
                    byte_from_mem += block_size;
                }
                else byte_from_mem += block_size;
                Nway_Cache[n][index].dirty = 1;
            }  
        }  
        write_data++;      
    }
    if( label == 2 ) {
        for(i=0; i<row; i++){
            if(Nway_Cache[n][i].Tag == addr) {
                cache_hit++;
                find = 1;
                break;
            }
        }
  //      if( find==1 ) {
            for(int j=0; j<row; j++) {
                if(Nway_Cache[n][j].Tag != 0) {    
                    LRU_Cache[n][j]++;
                }
            }
 //       }
        LRU_Cache[n][i] = 0;
        if( find==0 ) {
            cache_miss++;
            for(i=0; i<row; i++) {
                if(Nway_Cache[n][i].Tag == 0) {
                    space = 1;
                    index = i;
                    break;
                }
                else LRU_Cache[n][i] ++;
            }
            if( space == 1 ) {
                Nway_Cache[n][index].Tag = addr;
                LRU_Cache[n][index] = 0;
                QueueCache[n].push(addr); 
                if(Nway_Cache[n][index].dirty==1) {
                    byte_to_mem += block_size;
                    byte_from_mem += block_size;
                }
                else byte_from_mem += block_size;
                Nway_Cache[n][index].dirty = 0;
            }
            else if( space==0 && policy==0 ) {                           //FIFO
                int out = QueueCache[n].front();
                QueueCache[n].pop();
                for(i=0; i<row; i++) {
                    if(Nway_Cache[n][i].Tag==out) {
                        Nway_Cache[n][i].Tag = addr;
                        QueueCache[n].push(addr);
                        break;
                    }
                }
                if(Nway_Cache[n][i].dirty==1) {
                    byte_to_mem += block_size;
                    byte_from_mem += block_size;
                }
                else byte_from_mem += block_size;
                Nway_Cache[n][i].dirty = 0;
            }  
            else if( space==0 && policy==1 ) {                           //LRU
                int max=0,index=0;
                for(i=0; i<row; i++) {
                    if(LRU_Cache[n][i] > max) {
                        max = LRU_Cache[n][i];
                        index = i;
                    }
                }
                i = index;
                Nway_Cache[n][i].Tag = addr;
                for(i=0; i<row; i++) {
                    LRU_Cache[n][i]++;
                }
                LRU_Cache[n][index] = 0;
                if(Nway_Cache[n][index].dirty==1) {
                    byte_to_mem += block_size;
                    byte_from_mem += block_size;
                }
                else byte_from_mem += block_size;
                Nway_Cache[n][index].dirty = 0;
            }  
            
        }        
    }  
  
    
}
int main(int argc, char *argv[]) {
    if(argc==6) {
        unsigned int addr;
        int label,policy,row,column;
        FILE *din = fopen(argv[5],"r");
        char f_line[25] = "\0";
        int num_fetch=0, num_block;
        cache_hit=0, cache_miss=0, read_data=0, write_data=0, byte_from_mem=0, byte_to_mem=0;
        cache_size = atoi(argv[1]);
        block_size = atoi(argv[2]);
        num_block = cache_size * 1024 / block_size;
        if(atoi(argv[3]) == 1) {                                               // Direct Mapped
            Cache block[num_block];
            for(int i=0; i<num_block; i++) {
                block[i].Tag = 0;
                block[i].dirty = 0;
            }
            while( fgets(f_line, 20, din) ) {                                  //一行一行讀資料，存入f_line
                sscanf(f_line,"%d %x", &label, &addr);                         // label 存 Label, addr 存地址    
                put_direct_data(block, label, addr, num_block);   
                num_fetch++;  
            } 
            for(int i=0; i<num_block; i++) {
                if( block[i].dirty == 1 ) byte_to_mem += block_size;
            } 
        }
        else {
            if(strcmp(argv[4],"FIFO")==0) policy = 0;
            if(strcmp(argv[4],"LRU")==0) policy = 1;
           
            if(atoi(argv[3]) == 2) {                                           // 2-way set associative                          
                row = 2;
                column = num_block / 2;
            }
            else if(atoi(argv[3]) == 4) {                                      // 4-way set associative                          
                row = 4;    
                column = num_block / 4;
            }
            else if(atoi(argv[3]) == 8) {                                      // 8-way set associative                          
                row = 8;    
                column = num_block / 8;
            }
            else if(!strcmp(argv[3] , "f")) {                                          // full associative        
                row = cache_size * 1024 / block_size;
                column = 1;                
            }

            Nway_Cache = new Cache*[column];
            LRU_Cache = new int*[column];
            QueueCache = new queue<int>[column];

            for(int i=0; i<column; i++) {
                Nway_Cache[i] = new Cache[row];
                LRU_Cache[i] = new int[row];
            }

            for(int i=0; i<column; i++) {
                for(int j=0; j<row; j++) {
                    Nway_Cache[i][j].Tag = 0;
                    Nway_Cache[i][j].dirty = 0;
                    LRU_Cache[i][j] = 0;
                }
            }
            while( fgets(f_line, 20, din) ) {                                  //一行一行讀資料，存入f_line
                sscanf(f_line,"%d %x", &label, &addr);                         // label 存 Label, addr 存地址    
                put_nway_data(label, addr, row, column, policy);   
                num_fetch++;  
            } 
            for(int i=0; i<column; i++) {
                for(int j=0; j<row; j++) {
                    if( Nway_Cache[i][j].dirty == 1 ) byte_to_mem += block_size;
                }
            }
        }
        printf("Input file = %s\n",argv[5]);
        printf("Demand fetch = %d\n",num_fetch);
        printf("Cache hit = %d\n",cache_hit);
        printf("Cache miss = %d\n",cache_miss);
        printf("Miss Rate = %.4f\n",(double)cache_miss/(double)num_fetch);
        printf("Read data = %d\n",read_data);
        printf("Write data = %d\n",write_data);
        printf("Bytes from memory = %d\n",byte_from_mem);
        printf("Bytes to memory = %d\n",byte_to_mem);
    }
    return 0;
}

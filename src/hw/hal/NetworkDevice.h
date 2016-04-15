// This file is part of CiAO/IP.
//
// CiAO/IP is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// CiAO/IP is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with CiAO/IP.  If not, see <http://www.gnu.org/licenses/>.
// 
// Copyright (C) 2011 Christoph Borchert


#ifndef __NETWORK_DEVICE__
#define __NETWORK_DEVICE__

namespace hw {
namespace hal {

class NetworkDevice {
  protected:
  //called if this device should be added to the IP stack
  void init() {}
  //called by rx interrupt in order delived the packet to the IP stack
  void demux(const void* data, unsigned size) {}
  
  public:
  //called by the IP stack
  virtual const char* getName() = 0;
  virtual unsigned getMTU() = 0;
  virtual unsigned char getType() = 0;
  virtual const unsigned char* getAddress() { return 0; }
  
  virtual void send(const void* data, unsigned datasize) = 0;
  virtual bool hasBeenSent(const void* addr) { return true; }
  
  //optional, for hardware checksumm offloading, only
  virtual bool hasTransmitterHardwareChecksumming() { return false; }
  virtual bool hasReceiverHardwareChecksumming() { return false; }
  virtual void send(const void* data, unsigned datasize, bool tcp, unsigned ip_hdl) {}
};

}
}

#endif /* __NETWORK_DEVICE__ */


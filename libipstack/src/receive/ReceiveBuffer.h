// This file is part of Aspect-Oriented-IP.
//
// Aspect-Oriented-IP is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Aspect-Oriented-IP is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Aspect-Oriented-IP.  If not, see <http://www.gnu.org/licenses/>.
//
// Copyright (C) 2012 David Gräff

#pragma once
/**
 * Purpose: A receive buffer is generated by the copyPayloadData method,
 * where the received payload data of a network packet is copied to the
 * socket ("userspace" task).
 *
 * To get the next received payload data, call receive() on the socket.
 * You have to free the returned ReceiveBuffer object by calling
 * ReceiveBuffer::free(objectname);
 *
 * If multiple payload data have been received before the socket receive() method is
 * called, the oldest ReceiveBuffer is returned.
 *
 * If you are interested in the sender IP and port of an received UDP datagram,
 * use a typecast, depending on your IP version. 0 is returned if the cast failed.
 * Try the other IP version on a dual-stack then. Example:
 * 
 * ReceiveBuffer* r = socket.receive();
 * ReceiveBufferUDPipV4* r_ipv4 = ReceiveBufferUDPipV4::cast(r);
 * if (r_ipv4) { do something; }
 * ReceiveBufferUDPipV6* r_ipv6 = ReceiveBufferUDPipV6::cast(r);
 */

#include "util/ipstack_inttypes.h"
#include "util/MemoryInterface.h"
#include <string.h> //for memcpy

namespace ipstack
{

class ReceiveBuffer
{
	public:
		/**
		 * Create a receive buffer and return it.
		 * Changes the ReceiveBuffer list-head pointer if neccessary.
		 */
		static ReceiveBuffer* createReceiveBuffer(MemoryInterface* mem, void*  payload, uint16_t payloadsize) {
			ReceiveBuffer* r = (ReceiveBuffer*)mem->alloc(payloadsize + sizeof(ReceiveBuffer));
			if (!r)
				return 0;

			r->m_mem = mem;
			r->m_receivedSize = payloadsize;
			memcpy(r->m_dataStart, payload, payloadsize);
			return r;
		}

		static void free(ReceiveBuffer* b) {
			MemoryInterface* m_mem = b->m_mem;
			m_mem->free((void*)b);
		}
		
		/**
		 * Return a pointer to the data.
		 * */
		void* getData() {
			return m_dataStart;
		}

		/**
		 * Return the size in bytes of the received data
		 * */
		uint16_t getSize() {
			return m_receivedSize;
		}
	private:
		/**
		 * The constructor is hidden. the createReceiveBuffer method has to be used
		 */
		ReceiveBuffer()  {};
	protected:
		MemoryInterface* m_mem;
		uint16_t m_receivedSize;
		char m_dataStart[]; // data block starts here

};

} // namespace ipstack

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
// Copyright (C) 2012 David Gräff

#pragma once

#include "util/types.h"
#include "ipstack/ipv6/IPv6AddressUtilities.h"

namespace ipstack
{

class IPv6_Packet
{
	public:
		enum { ETH_TYPE_IPV6 = 0x86DD, //Ethernet type value, 0x86DD for ipv6 (rfc2464)
			   IPV6_VERSION = 6,
			   IPV6_HEADER_SIZE_IN_BYTES = 40
			 };

		enum { IPV6_DEFAULT_TOS = 0,
			   IPV6_DEFAULT_HOPLIMIT = 255
			 };

		enum { IPV6_UNUSED_ADDR = 0 }; // http://www.rfc-editor.org/rfc/rfc5735.txt

	private:
		UInt8 traffic_class1: 4,
			  version: 4;
		UInt8 traffic_class2_flowLabel1;
		UInt8 flowLabel2;
		UInt8 flowLabel3;
		UInt16 payload_length; // byte order!
		UInt8 nextheader;
		UInt8 hoplimit;
		ipv6addr src_ipaddr;
		ipv6addr dst_ipaddr;

		UInt8 payload[];

	public:
		void setUpHeader() {
			// At the moment flow and traffic class are just 0. For sending and receiving.
			// This is allowed for a host implementation as of RFC2460.
			flowLabel3 = 0;
			flowLabel2 = 0;
			traffic_class2_flowLabel1 = 0;
			traffic_class1 = 0;
			version = IPV6_VERSION;
		}
		UInt16 get_payload_len() {
			return payload_length;
		}
		void set_payload_len(UInt16 len) {
			payload_length = len;
		}

		UInt8 get_version() {
			return version;
		}
		
		UInt8 get_hoplimit() {
			return hoplimit;
		}
		void set_hoplimit(UInt8 t) {
			hoplimit = t;
		}

		UInt8 get_nextheader() {
			return nextheader;
		}
		void set_nextheader(UInt8 i) {
			nextheader = i;
		}
		char* get_nextheaderPointer() {
			return (char*)&nextheader;
		}

		ipv6addr get_src_ipaddr() {
			return src_ipaddr;
		}
		void set_src_ipaddr(const ipv6addr& addr) {
			copy_ipv6_addr(addr, src_ipaddr);
		}

		ipv6addr get_dst_ipaddr() {
			return dst_ipaddr;
		}
		
		void set_dst_ipaddr(const ipv6addr& addr) {
			copy_ipv6_addr(addr, dst_ipaddr);
		}

		UInt8* get_payload() {
			// return pointer to payload
			return (UInt8*)(payload);
		}

		unsigned validPacketLength(unsigned packet_len_in_bytes) {
			//returns 0 if packet length is invalid
			//returns the valid ipv6 packet length otherwise

			if (packet_len_in_bytes < IPV6_HEADER_SIZE_IN_BYTES) {
				//packet too small!
				return 0;
			}

			//Get length of ipv6 packet. Byte order conversion is
			//done by an aspect affecting "get_total_len()".
			//Safe this value to avoid redundant conversions.
			const UInt16 total_len = get_payload_len();

			if (total_len > packet_len_in_bytes) {
				//ip paket size is bigger than the entire buffer!
				return 0;
			}
			// in contrast to IPv4: total_len == payload_length. The IP header is not counted.
			return total_len;
		}
} __attribute__((packed));  //__attribute__ ((aligned(1), packed));

} //namespace ipstack

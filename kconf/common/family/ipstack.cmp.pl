$VAR1 = {
	'vname' => 'IP Stack',
	'name' => 'ipstack',
	'dir' => 'ipstack',
	'depends' => '&ipstack',
	'comp' => [
	{
		'file' => 'IPStack_Config.h',
		'srcfile' => 'IPStack_Config_kconf.h'
	},
	{
		'vname' => 'Router',
		'name' => 'ipstack_router',
		'subdir' => '/router',
		'files' => [
			'Interface.h',
			'Interface.ah',
			'Interface_Delegation.ah',
			'Router.h',
			'Router.cpp',
			'Router.ah'
		]
	},
	{
		'vname' => 'Demux',
		'name' => 'ipstack_demux',
		'depends' => '&ipstack_ipv4_recv or &ipstack_arp_ipv4_request or &ipstack_arp_ipv4_reply',
		'subdir' => '/demux',
		'files' => [
			'Demux.h',
			'Demux.cpp',
			'Demux.ah'
		]
	},
	{
		'vname' => 'Util',
		'name' => 'ipstack_util',
		'subdir' => '/util',
		'comp' => [
		{
			'files' => [
				'Mempool.h',
				'MempoolBase.h',
				'Ringbuffer.h',
				'RingbufferBase.h'
			]
		}
		]
	},
	{
		'depends' => '&ipstack_byteorder_little',
		'file' => 'Little_Endian.ah'
	},
	{
		'vname' => 'Autosar OS Integration',
		'name' => 'ipstack_autosar',
		'subdir' => '/as',
		'comp' => [
		{
			'depends' => '&ipstack_irqsync',
			'file' => 'IRQ_Sync.ah'
		},
		{
			'depends' => '&ipstack_clock',
			'subdir' => '..',
			'file' => 'Clock.h',
			'srcfile' => 'as/Clock.h'
		},
		{
			'depends' => '&ipstack_autosar_event',
			'files' => [
				'EventSupport.ah',
				'EventSupport.h',
				'EventSupport_Slice.ah'
			]
		},
		{
			'depends' => '&ipstack_autosar_alarm and &ipstack_autosar_event',
			'files' => [
				'AlarmSupport.ah',
				'AlarmSupport_Slice.ah',
			]
		},
		{
			'depends' => '&ipstack_autosar_reschudule_arp_ipv4_request',
			'file' => 'ARP_Cache_Send_Reschedule.ah'
		},
		{
			'depends' => '&ipstack_autosar_reschudule_udp_ipv4_send',
			'file' => 'UDP_Send_Reschedule.ah'
		}
		]
	},
	{
		'depends' => '&ipstack_linklayer_ethernet',
		'file' => 'Eth_Frame.h'
	},
	{
		'vname' => 'IPv4',
		'name' => 'ipstack_ipv4',
		'depends' => '&ipstack_ipv4',
		'subdir' => '/ipv4',
		'comp' => [
		{
			'files' => [
				'Interface_IPv4_Slice.ah',
				'IPv4.h',
				'IPv4.ah',
				'IPv4_Socket.h',
				'IPv4_Socket.cpp',
				'Router_IPv4_Slice.ah'
			]
		},
		{
			'vname' => 'IPv4 Receiving',
			'name' => 'ipstack_ipv4_recv',
			'depends' => '&ipstack_ipv4_recv',
			'comp' => [
			{
				'files' => [
					'IPv4_Receive.ah',
					'Demux_IPv4_Slice.ah'
				]
			},
			{
				'depends' => '&ipstack_linklayer_ethernet',
				'file' => 'IPv4_Receive_Ethernet.ah'
			},
			{
				'depends' => '&ipstack_ipv4_recv_fragments',
				'file' => 'IPv4_Receive_Fragment_Reassembly.ah'
			}
			]
		},
		{
			'depends' => '&ipstack_ipv4_send and &ipstack_linklayer_ethernet',
			'file' => 'IPv4_Socket_Ethernet.ah'
		},
		{
			'depends' => '&ipstack_ipv4_fwd and &ipstack_ipv4_recv',
			'file' => 'IPv4_Forward.ah'
		}
		]
	},
	{
		'vname' => 'ARP',
		'name' => 'ipstack_arp',
		'depends' => '&ipstack_arp',
		'subdir' => '/arp',
		'comp' => [
		{
			'files' => [
				'ARP.h',
				'Demux_ARP_Slice.ah',
				'ARP.ah',
				'ARP_Cache.cpp',
				'ARP_Cache.h'
			]
		},
		{
			'depends' => '&ipstack_arp_timeout',
			'file' => 'ARP_Cache_Global_Timeout.ah'
		},
		{
			'depends' => '&ipstack_arp_ipv4 and &ipstack_linklayer_ethernet',
			'file' => 'ARP_Ethernet.ah'
		},
		{
			'vname' => 'ARP - IPv4 over Ethernet',
			'name' => 'ipstack_arp_ipv4',
			'depends' => '&ipstack_arp_ipv4 and &ipstack_linklayer_ethernet and &ipstack_ipv4',
			'subdir' => '/ipv4',
			'comp' => [
			{
				'files' => [
					'ARP_Cache_IPv4_Slice.ah',
					'IPv4_ARP.ah'
				]
			},
			{
				'vname' => 'ARP Request or Reply',
				'name' => 'ipstack_arp_ipv4_requestorreply',
				'depends' => '&ipstack_arp_ipv4_request or &ipstack_arp_ipv4_reply',
				'files' => [
					'Eth_ARP_IPv4_Packet.h',
					'IPv4_ARP_Send_Receive.ah',
					'ARP_Cache_IPv4_Send_Receive_Slice.ah'
				]
			},
			{
				'vname' => 'ARP Request',
				'name' => 'ipstack_arp_ipv4_request',
				'depends' => '&ipstack_arp_ipv4_request',
				'files' => [
					'ARP_Cache_IPv4_Send_Slice.ah',
					'IPv4_Socket_Ethernet_ARP.ah',
					'IPv4_Socket_Ethernet_ARP_Slice.ah',
					'IPv4_ARP_Send.ah'
				]
			},
			{
				'vname' => 'ARP Reply',
				'name' => 'ipstack_arp_ipv4_reply',
				'depends' => '&ipstack_arp_ipv4_reply',
				'file' => 'IPv4_ARP_Receive.ah'
			},
			{
				'vname' => 'Static Cache Entries',
				'name' => 'ipstack_arp_ipv4_static',
				'depends' => '&ipstack_arp_ipv4_static',
					'files' => [
					'ARP_Cache_IPv4_Static_Slice.ah',
					'IPv4_ARP_Static.ah'
				]
			}
			]
		}
		]
	},
	{
		'vname' => 'ICMP',
		'name' => 'ipstack_icmp',
		'depends' => '&ipstack_icmp',
		'subdir' => '/icmp',
		'comp' => [
		{
			'files' => [
				'ICMP.h'
			]
		}
		]
	},
	{
		'vname' => 'ICMP over IPv4',
		'name' => 'ipstack_icmp_ipv4',
		'depends' => '&ipstack_icmp_ipv4 and &ipstack_icmp and &ipstack_ipv4',
		'subdir' => '/ipv4/ipv4_icmp',
		'comp' => [
		{
			'files' => [
				'IPv4_ICMP_Ethernet.ah',
				'Demux_IPv4_ICMP_Slice.ah',
				'IPv4_ICMP_Receive.ah'
			]
		},
		{
			'vname' => 'ICMP over IPv4 - Echo Reply',
			'name' => 'ipstack_icmp_ipv4_echoreply',
			'depends' => '&ipstack_icmp_ipv4_echoreply',
			'comp' => [
			{
				'files' => [
					'IPv4_ICMP_Echo_Reply.ah'
				]
			}
			]
		},
		{
			'vname' => 'ICMP over IPv4 - Destination Unreachable',
			'name' => 'ipstack_icmp_ipv4_destinationunreachable',
			'depends' => '&ipstack_icmp_ipv4_destinationunreachable',
			'comp' => [
			{
				'vname' => 'ICMP over IPv4 - Destination Unreachable - Protocol Unreachable',
				'name' => 'ipstack_icmp_ipv4_destinationunreachable_protocolunreachable',
				'depends' => '&ipstack_icmp_ipv4_destinationunreachable_protocolunreachable',
				'comp' => [
				{
					'files' => [
						'IPv4_ICMP_Protocol_Unreachable.ah'
					]
				}
				]
			},
			{
				'vname' => 'ICMP over IPv4 - Destination Unreachable - Port Unreachable',
				'name' => 'ipstack_icmp_ipv4_destinationunreachable_portunreachable',
				'depends' => '&ipstack_icmp_ipv4_destinationunreachable_portunreachable and &ipstack_udp_ipv4',
				'comp' => [
				{
					'files' => [
						'IPv4_ICMP_Port_Unreachable.ah'
					]
				}
				]
			}
			]
		}
		]
	},
	{
		'vname' => 'UDP',
		'name' => 'ipstack_udp',
		'depends' => '&ipstack_udp',
		'subdir' => '/udp',
		'comp' => [
		{
			'files' => [
				'UDP.h',
				'UDP_Socket.h'
			]
		}
		]
	},
	{
		'vname' => 'UDP over IPv4',
		'name' => 'ipstack_udp_ipv4',
		'depends' => '&ipstack_udp_ipv4 and &ipstack_udp and &ipstack_ipv4',
		'subdir' => '/ipv4/ipv4_udp',
		'comp' => [
		{
			'files' => 'IPv4_UDP_Socket.(h|cpp)'
		},
		{
			'vname' => 'UDP over IPv4 - Sending',
			'name' => 'ipstack_udp_ipv4_send',
			'depends' => '&ipstack_udp_ipv4_send',
			'comp' => [
			{
				'files' => [
					'IPv4_UDP_Send.ah',
					'IPv4_UDP_Socket_Send_Slice.ah'
				]
			},
			{
				'depends' => '&ipstack_udp_ipv4_send_checksum',
				'file' => 'IPv4_UDP_Tx_Checksumming.ah'
			}
			]
		},
		{
			'vname' => 'UDP over IPv4 - Receiving',
			'name' => 'ipstack_udp_ipv4_recv',
			'depends' => '&ipstack_udp_ipv4_recv',
			'comp' => [
			{
				'files' => [
					'Demux_IPv4_UDP_Slice.ah',
					'IPv4_UDP_Receive.ah',
					'IPv4_UDP_Socket_Receive_Slice.ah'
				]
			},
			{
				'depends' => '&ipstack_udp_ipv4_recv_checksum',
				'file' => 'IPv4_UDP_Rx_Checksumming.ah'
			}
			]
		}
		]
	},
	{
		'vname' => 'Internet Checksum',
		'name' => 'ipstack_inetchecksum',
		'depends' => '&ipstack_icmp_ipv4_recv_checksum or &ipstack_icmp_ipv4_send_checksum or &ipstack_udp_ipv4_recv_checksum or &ipstack_udp_ipv4_send_checksum or &ipstack_tcp',
		'subdir' => '/ipv4',
		'comp' => [
		{
			'file' => 'InternetChecksum.h'
		},
		{
			'depends' => '&ipstack_linklayer_offloading_tx',
			'file' => 'InternetChecksum_Tx_Offloading.ah'
		},
		{
			'depends' => '&ipstack_linklayer_offloading_rx',
			'file' => 'InternetChecksum_Rx_Offloading.ah'
		}
		]
	},
	{
		'vname' => 'TCP',
		'name' => 'ipstack_tcp',
		'depends' => '&ipstack_tcp',
		'subdir' => '/tcp',
		'comp' => [
		{
			'files' => [
				'TCP.h',
				'TCP_Send.cpp',
				'TCP_Socket.cpp',
				'TCP_Socket.h',
			]
		},
		{
			'subdir' => '/statemachine',
			'comp' => [
			{
				'files' => [
					'closed.ah',
					'closewait.ah',
					'closing.ah',
					'established.ah',
					'finwait1.ah',
					'finwait2.ah',
					'lastack.ah',
					'listen.ah',
					'synrcvd.ah',
					'synsent.ah',
					'timewait.ah',
					'TCP_Statemachine.ah'
				]
			},
			{
				'depends' => 'not &ipstack_tcp_ipv4_client',
				'file' => 'synsent_dummy.ah'
			},
			{
				'depends' => 'not &ipstack_tcp_ipv4_listen',
				'file' => 'listen_dummy.ah'
			}
			]
		},
		{
			'subdir' => '/tcp_history',
			'comp' => [
			{
				'files' => [
					'TCP_History.h',
					'TCP_History.cpp',
					'TCP_Record.h',
					'TCP_Record.cpp'
				]
			},
			{
				'vname' => 'Send Sliding Window',
				'depends' => '&ipstack_tcp_slidingwnd_send',
				'comp' => [
				{
					'files' => [
						'TCP_History_SlidingWindow.ah',
						'TCP_History_SlidingWindow_Slice.ah',
						'TCP_Record_SlidingWindow_Slice.ah'
					]
				}
				]
			},
			{
				'vname' => 'Limit excessive Retransmissions',
				'depends' => '&ipstack_tcp_limit_retransmissions',
				'comp' => [
				{
					'files' => [
						'TCP_Record_RetransmissionCounter.ah',
						'TCP_Record_RetransmissionCounter_Slice.ah'
					]
				}
				]
			}
			]
		},
		{
			'subdir' => '/tcp_receivebuffer',
			'comp' => [
			{
				'files' => [
					'TCP_ReceiveBuffer.cpp',
					'TCP_ReceiveBuffer.h',
					'TCP_RecvElement.h'
				]
			},
			{
				'vname' => 'Receive Sliding Window',
				'depends' => '&ipstack_tcp_slidingwnd_recv',
				'files' => [
					'TCP_ReceiveBuffer_SlidingWindow.ah',
					'TCP_ReceiveBuffer_SlidingWindow_Slice.ah',
					'TCP_RecvElement_SlidingWindow_Slice.ah'
				]
			}
			]
		},
		{
			'vname' => 'TCP Sliding Window Flags Config',
			'comp' => [
			{
				'depends' => '&ipstack_tcp_slidingwnd_send and &ipstack_tcp_slidingwnd_recv',
				'generate' => 'sprintf("#ifndef __TCP_CONFIG_H__\n#define __TCP_CONFIG_H__\n\n#include \"../IPStack_Config.h\"\n\nnamespace ipstack {\nenum {\nTCP_RECEIVEBUFFER_MAX_PACKETS = PACKET_LIMIT, \nTCP_HISTORY_MAX_PACKETS = PACKET_LIMIT };\n}\n\n#endif // __TCP_CONFIG_H__\n")',
				'file' => 'TCP_Config.h'
			},
			{
				'depends' => '&ipstack_tcp_slidingwnd_send and not &ipstack_tcp_slidingwnd_recv',
				'generate' => 'sprintf("#ifndef __TCP_CONFIG_H__\n#define __TCP_CONFIG_H__\n\n#include \"../IPStack_Config.h\"\n\nnamespace ipstack {\nenum {\nTCP_RECEIVEBUFFER_MAX_PACKETS = 1, \nTCP_HISTORY_MAX_PACKETS = PACKET_LIMIT };\n}\n\n#endif // __TCP_CONFIG_H__\n")',

				'file' => 'TCP_Config.h'
			},
			{
				'depends' => 'not &ipstack_tcp_slidingwnd_send and &ipstack_tcp_slidingwnd_recv',
				'generate' => 'sprintf("#ifndef __TCP_CONFIG_H__\n#define __TCP_CONFIG_H__\n\n#include \"../IPStack_Config.h\"\n\nnamespace ipstack {\nenum {\nTCP_RECEIVEBUFFER_MAX_PACKETS = PACKET_LIMIT, \nTCP_HISTORY_MAX_PACKETS = 1 };\n}\n\n#endif // __TCP_CONFIG_H__\n")',
				'file' => 'TCP_Config.h'
			},
			{
				'depends' => 'not &ipstack_tcp_slidingwnd_send and not &ipstack_tcp_slidingwnd_recv',
				'generate' => 'sprintf("#ifndef __TCP_CONFIG_H__\n#define __TCP_CONFIG_H__\n\n#include \"../IPStack_Config.h\"\n\nnamespace ipstack {\nenum {\nTCP_RECEIVEBUFFER_MAX_PACKETS = 1, \nTCP_HISTORY_MAX_PACKETS = 1 };\n}\n\n#endif // __TCP_CONFIG_H__\n")',
				'file' => 'TCP_Config.h'
			}
			]
		},
		{
			'subdir' => '/sws',
			'comp' => [
			{
				'depends' => '&ipstack_tcp_sws_send',
				'files' => [
					'SWS_SenderAvoidance.ah',
					'SWS_SenderAvoidance_Slice.ah'
				]
			},
			{
				'depends' => '&ipstack_tcp_sws_recv',
				'file' => 'SWS_ReceiverAvoidance.ah'
			},
			]
		},
		{
			'vname' => 'TCP Options',
			'subdir' => '/tcp_options',
			'comp' => [
			{
				'depends' => '&ipstack_tcp_mss',
				'files' => [
					'MSS.ah',
					'MSS_TCP_Segment_Slice.ah',
					'MSS_TCP_Socket_Slice.ah'
				]
			}
			]
		},
		{
			'vname' => 'Retransmission Tracker',
			'depends' => '&ipstack_tcp_rtt or &ipstack_tcp_congestionavoidance',
			'comp' => [
			{
				'vname' => 'TCP Retransmission Tracker',
				'files' => [
					'TCP_RetransmissionTracker.ah',
					'TCP_RetransmissionTrackerSlice.ah'
				]
			}
			]
		},
		{
			'vname' => 'RTT Estimation',
			'subdir' => '/rtt_estimation',
			'depends' => '&ipstack_tcp_rtt',
			'comp' => [
			{
				'vname' => 'Mean and Deviation Meassure',
				'files' => [
					'RTT_Estimation.ah',
					'RTT_Estimation_Slice.ah'
				]
			},
			{
				'vname' => 'Exponential Backoff',
				'depends' => '&ipstack_tcp_rtt_backoff',
				'file' => 'RTT_Exponential_Backoff.ah'
			}
			]
		},
		{
			'vname' => 'Congestion Avoidance',
			'subdir' => '/congestion_avoidance',
			'depends' => '&ipstack_tcp_congestionavoidance',
			'comp' => [
			{
				'vname' => 'Slow Start',
				'depends' => '&ipstack_tcp_congestionavoidance_slowstart',
				'files' => [
					'SlowStart.ah',
					'SlowStart_Slice.ah'
				]
			}
			]
		}
		]
	},
	{
		'vname' => 'TCP over IPv4',
		'name' => 'ipstack_tcp_ipv4',
		'depends' => '&ipstack_tcp_ipv4 and &ipstack_tcp and &ipstack_ipv4',
		'subdir' => '/ipv4/ipv4_tcp',
		'comp' => [
		{
			'files' => [
				'Demux_IPv4_TCP_Slice.ah',
				'IPv4_TCP_Receive.ah',
				'IPv4_TCP_Socket.h',
				'IPv4_TCP_Socket.cpp',
				'IPv4_TCP_Tx_Checksumming.ah',
			]
		},
		{
			'vname' => 'Listen Sockets',
			'name' => 'ipstack_tcp_ipv4_listen',
			'depends' => '&ipstack_tcp_ipv4_listen',
			'files' => [
				'Demux_IPv4_TCP_Listen_Slice.ah',
				'IPv4_TCP_Listen.ah',
				'IPv4_TCP_Socket_Listen_Slice.ah'
			]
		},
		{
			'vname' => 'Reset invalid Packets',
			'name' => 'ipstack_tcp_ipv4_reset',
			'depends' => '&ipstack_tcp_ipv4_reset',
			'comp' => [
			{
				'files' => [
					'Demux_IPv4_TCP_Reset_Slice.ah',
					'IPv4_TCP_Reset.ah'
				]
			},
			{
				'depends' => '&ipstack_linklayer_ethernet',
				'file' => 'IPv4_TCP_Reset_Ethernet.ah'
			}
			]
		}
		]
	},
	{
		'vname' => 'Template API',
		'name' => 'ipstack_api',
		'subdir' => '/api',
		'comp' => [
		{
			'depends' => '&ipstack_udp_ipv4',
			'file' => 'IPv4_UDP_Socket.h'
		},
		{
			'depends' => '&ipstack_tcp_ipv4',
			'file' => 'IPv4_TCP_Socket.h'
		},
		{
			'file' => 'Setup.h'
		}
		]
	}
	]
};

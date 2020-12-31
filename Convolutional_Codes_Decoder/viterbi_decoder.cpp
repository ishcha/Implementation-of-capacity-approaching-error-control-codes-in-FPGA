#include <iostream>
#include <bits/stdc++.h>

using namespace std;

int main()
{
	int m1 = 2, s = pow(2, m1);
	vector<int> r (14);
	map<pair<int, int>, int> m;
	m[{0, 0}] = 0;
	for (int f = 0; f < r.size(); f++) {
		cin >> r[f];
	}
	vector<string> sp(s, "");
	int i;
	for (i = 0; i < s-1; i+=2) {
		vector<pair<pair<int, int>, int>> c;
		vector<string> sp_ahead(s, "");				
		for (auto j = m.begin(); j != m.end(); j++) {
			//cout << i << " " << (j->first) << (j->second) <<'\n';
			//cout<< j->first <<'\n';
			//cout << i << " " << j->first.first << "      " << j->first.second << endl; 
			int v01, v02, s01, s02, v11, v12, s11, s12;
			v01 = j->first.second;
			v02 = j->first.first ^ j->first.second;
			s01 = 0;
			s02 = j->first.first;
			v11 = 1 ^ j->first.second;
			v12 = (1 ^ j->first.first) ^ j->first.second;
			s11 = 1;
			s12 = j->first.first;
			//cout << i << " " << j->first.first << "      " << j->first.second << " " << s01 << s02 << s11 << s12 << endl;
			string e = sp[j->first.first*2 + j->first.second];
			sp_ahead[s01*2 + s02] = e + to_string(v01) + to_string(v02) + ",";
			sp_ahead[s11*2 + s12] = e + to_string(v11) + to_string(v12) + ",";
			c.push_back({{s01, s02}, j->second + (v01 ^ r[i]) + (v02 ^ r[i+1])});
			c.push_back({{s11, s12}, j->second + (v11 ^ r[i]) + (v12 ^ r[i+1])});
			// if ((s11 == 1) && (s12 == 0)) {
			// 	cout << "Yes" <<'\n';
			// 	cout << j->second <<'\n';
			// 	cout << (v11 ^ r[i]) <<'\n';
			// 	cout << (v11 ^ r[i]) <<'\n';
			// }
		}
		for (int a = 0; a < c.size(); a++) {
			m[{c[a].first.first, c[a].first.second}] = c[a].second;
			//cout << i << c[a].first.first << c[a].first.second << c[a].second <<'\n';
		}
		for (int u = 0; u < sp.size(); u++) {
			sp[u] = sp_ahead[u];
		}
		// cout << "start" <<'\n';
		// cout << sp[0] <<'\n';
		// cout << sp[1] <<'\n';
		// cout << sp[2] <<'\n';
		// cout << sp[3] <<'\n';
		// cout << "end" <<'\n';
	}

		// cout << "start" <<'\n';
		// cout << sp[0] <<'\n';
		// cout << sp[1] <<'\n';
		// cout << sp[2] <<'\n';
		// cout << sp[3] <<'\n';
		// cout << "end" <<'\n';

	// cout << "hi" <<'\n';
	// 	cout << m[{0, 0}] <<'\n';
	// 	cout << m[{0, 1}] <<'\n';
	// 	cout << m[{1, 0}] <<'\n';
	// 	cout << m[{1, 1}] <<'\n';
	// 	cout << "bye" <<'\n';


	for (i = s; i < r.size()-s-1; i+=2) {
		vector<int> vis(s, 0);
		vector<string> sp_ahead(s, "");	
		map<pair<int, int>, int> m_ahead;
		for (auto j = m.begin(); j != m.end(); j++) {
			//cout << i << " " << j->first.first << "      " << j->first.second << endl; 
			int v01, v02, s01, s02, v11, v12, s11, s12;
			v01 = j->first.second;
			v02 = j->first.first ^ j->first.second;
			s01 = 0;
			s02 = j->first.first;
			v11 = 1 ^ j->first.second;
			v12 = (1 ^ j->first.first) ^ j->first.second;
			s11 = 1;
			s12 = j->first.first;
			string e = sp[j->first.first*2 + j->first.second];
			if (vis[s01*2 + s02] == 0) {
				vis[s01*2 + s02] = 1;
				m_ahead[{s01, s02}] = j->second + (v01 ^ r[i]) + (v02 ^ r[i+1]);
				sp_ahead[s01*2 + s02] = e + to_string(v01) + to_string(v02) + ",";
			}
			else {
				if (m_ahead[{s01, s02}] > j->second + (v01 ^ r[i]) + (v02 ^ r[i+1])) {
					m_ahead[{s01, s02}] = j->second + (v01 ^ r[i]) + (v02 ^ r[i+1]);
					sp_ahead[s01*2 + s02] = e + to_string(v01) + to_string(v02) + ",";
				}
			}
			if (vis[s11*2 + s12] == 0) {
				vis[s11*2 + s12] = 1;
				m_ahead[{s11, s12}] = j->second + (v11 ^ r[i]) + (v12 ^ r[i+1]);
				sp_ahead[s11*2 + s12] = e + to_string(v11) + to_string(v12) + ",";
			}
			else {
				if (m_ahead[{s11, s12}] > j->second + (v11 ^ r[i]) + (v12 ^ r[i+1])) {
					m_ahead[{s11, s12}] = j->second + (v11 ^ r[i]) + (v12 ^ r[i+1]);
					sp_ahead[s11*2 + s12] = e + to_string(v11) + to_string(v12) + ",";
				}
			}
		}
		for (int u = 0; u < sp.size(); u++) {
			sp[u] = sp_ahead[u];
		}

		for (auto b1 = m.begin(); b1 != m.end(); b1++) {
			b1->second = m_ahead[b1->first];
		}
		cout << "start" <<'\n';
		cout << sp[0] <<'\n';
		cout << sp[1] <<'\n';
		cout << sp[2] <<'\n';
		cout << sp[3] <<'\n';
		cout << "end" <<'\n';
		//cout << sp[3]<<'\n';
		// cout << "hi" <<'\n';
		// cout << m[{0, 0}] <<'\n';
		// cout << m[{0, 1}] <<'\n';
		// cout << m[{1, 0}] <<'\n';
		// cout << m[{1, 1}] <<'\n';
		// cout << "bye" <<'\n';
	}

	cout << "start" <<'\n';
	cout << sp[0] <<'\n';
	cout << sp[1] <<'\n';
	cout << sp[2] <<'\n';
	cout << sp[3] <<'\n';
	cout << "end" <<'\n';

	for (i = r.size()-s; i < r.size(); i+=2) {
		vector<int> vis(s, 0);
		vector<string> sp_ahead(s, "");	
		map<pair<int, int>, int> m_ahead;
		for (auto j = m.begin(); j != m.end(); j++) {
			int v01, v02, s01, s02;
			v01 = j->first.second;
			v02 = j->first.first ^ j->first.second;
			s01 = 0;
			s02 = j->first.first;
			string e = sp[j->first.first*2 + j->first.second];
			if (vis[s01*2 + s02] == 0) {
				vis[s01*2 + s02] = 1;
				m_ahead[{s01, s02}] = j->second + (v01 ^ r[i]) + (v02 ^ r[i+1]);
				sp_ahead[s01*2 + s02] = e + to_string(v01) + to_string(v02) + ",";
			}
			else {
				if (m_ahead[{s01, s02}] > j->second + (v01 ^ r[i]) + (v02 ^ r[i+1])) {
					m_ahead[{s01, s02}] = j->second + (v01 ^ r[i]) + (v02 ^ r[i+1]);
					sp_ahead[s01*2 + s02] = e + to_string(v01) + to_string(v02) + ",";
				}
			}			
		}
		for (int k = 0; k < vis.size(); k++) {
			if (vis[k] == 0) {
				int h = k%2;
				int y = k/2;
				int r1 = y%2;
				m.erase({r1, h}); 
			}
		}
		//cout << "start" <<'\n';
		for (int u = 0; u < sp.size(); u++) {
			sp[u] = sp_ahead[u];
			cout << sp[u] <<'\n';
		}
		for (auto b1 = m.begin(); b1 != m.end(); b1++) {
			b1->second = m_ahead[b1->first];
		}
		//cout << "end" <<'\n';
		// cout << "hi" <<'\n';
		// cout << m[{0, 0}] <<'\n';
		// cout << m[{0, 1}] <<'\n';
		// cout << m[{1, 0}] <<'\n';
		// cout << m[{1, 1}] <<'\n';
		// cout << "bye" <<'\n';
	}

	cout << sp[0] <<'\n';
	cout << m[{0, 0}] <<'\n';

	return 0;
}
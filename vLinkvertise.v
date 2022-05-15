import net.http
import vweb
import json
import os
// import net.urllib
// import regex

const (
	reset   = '\x1b[39m'
	blue    = '\x1b[34m'
	cyan    = '\x1b[36m'
	red     = '\x1b[31m'
	magenta = '\x1b[35m'
	green   = '\x1b[32m'
	clear   = '\033[2J\033[1;1H'
)

struct ApiData {
	success bool
	// website string
	// query string
	destination string
	// cache bool
	// time_ms int
}

struct Api {
	vweb.Context
mut:
	state shared State
}

struct Web {
	vweb.Context
mut:
	state shared State
}

struct State {
mut:
	cnt int
}

fn bypass(link string) ?string {
	mut datafetch := http.post_json('https://api.bypass.vip/', json.encode({
		'url': '$link'
	})) or { return '$red Failed to fetch data $reset' }
	jsonfy := json.decode(ApiData, datafetch.text) or {
		return '$red Failed to decode json, error: $err $reset'
	}
	success := jsonfy.success
	//  website := jsonfy.website
	//  query := jsonfy.query
	result := jsonfy.destination
	//  cache := jsonfy.cache
	//  time_ms := jsonfy.time_ms

	if success == false {
		return '$red Invalid link $reset'
	}
	return result
	//** REGEX IMPLEMENTATION TO BE ADDED IN V2 **

	//     supported_urls := {
	//     "^https?://(linkvertise[.]com|linkvertise[.]net|link-to[.]net|linkvertise[.]download|file-link[.]net|direct-link[.]net|up-to-down[.]net|link-hub[.]net|link-center[.]net)/[0-9]+/[^/]+",
	//     "^https?://(linkvertise[.]com|linkvertise[.]net|link-to[.]net|linkvertise[.]download|file-link[.]net|direct-link[.]net|up-to-down[.]net|link-hub[.]net|link-center[.]net)/download/[0-9]+/[^/]+/.+",
	//     "^https?://(linkvertise[.]com|linkvertise[.]net|link-to[.]net|linkvertise[.]download|file-link[.]net|direct-link[.]net|up-to-down[.]net|link-hub[.]net|link-center[.]net)/premium-redirect/[0-9]+",
	//     "^https?://(linkvertise[.]com|linkvertise[.]net|link-to[.]net|linkvertise[.]download|file-link[.]net|direct-link[.]net|up-to-down[.]net|link-hub[.]net|link-center[.]net)/[0-9]+/[^/]+/dynamic/?",
	//     "^https?://(acconpit[.]com|aciterar[.]com|aclabink[.]com|activeation[.]com|activeterium[.]com|adf[.]acb[.]im|adf[.]ly|agileurbia[.]com|android-zone[.]org|anthargo[.]com|aporasal[.]net|aspedrom[.]com|atabencot[.]net|atharori[.]net|atomcurve[.]com|atominik[.]com|ay[.]gy|babblecase[.]com|battleate[.]com|beteshis[.]com|bitigee[.]com|blaleela[.]com|bluenik[.]com|botemoda[.]com|briskrange[.]com|brisktopia[.]com|caneddir[.]com|casualient[.]com|cesinthi[.]com|chinnica[.]net|cigorsica[.]com|clesolea[.]com|coginator[.]com|cogismith[.]com|combostruct[.]com|cowner[.]net|crefranek[.]com|criarysm[.]com|dapalan[.]com|dashsphere[.]com|dataurbia[.]com|deciomm[.]com|detonnot[.]com|dl[.]android-zone[.]org|ducolomal[.]com|ecleneue[.]com|eleburic[.]com|ethobleo[.]com|eunsetee[.]com|evassmat[.]com|evolterr[.]com|extrecey[.]com|fainbory[.]com|fasttory[.]com|fawright[.]com|fiaharam[.]net|flyserve[.]co|fumacrom[.]com|furtelec[.]com|gatustox[.]net|gdanstum[.]net|getrom[.]net|gloyah[.]net|greponozy[.]com|gusimp[.]net|hideadew[.]com|hinafinea[.]com|homoluath[.]com|hopigrarn[.]com|infopade[.]com|infortr[.]co[.]vu|intamema[.]com|ivononic[.]com|j[.]gs|kaitect[.]com|keistaru[.]com|kializer[.]com|kibuilder[.]com|kimechanic[.]com|ksatech[.]info|kudoflow[.]com|larati[.]net|legeerook[.]com|libittarc[.]com|linkjaunt[.]com|locinealy[.]com|lopoteam[.]com|maetrimal[.]com|meriabub[.]net|metastead[.]com|microify[.]com|mmoity[.]com|morebatet[.]com|motriael[.]com|movincle[.]com|neswery[.]com|nimbleinity[.]com|onisedeo[.]com|onizatop[.]net|optitopt[.]com|orablyro[.]com|out[.]unionfansub[.]com|packs[.]redmusic[.]pl|pheecith[.]com|picocurl[.]com|pintient[.]com|pladollmo[.]com|prereheus[.]com|q[.]gs|quainator[.]com|quamiller[.]com|queuecosm[.]bid|raboninco[.]com|rainonit[.]com|rantenah[.]com|rapidteria[.]com|rapidtory[.]com|regecish[.]net|riffhold[.]com|scapognel[.]com|scuseami[.]net|simizer[.]com|skamaker[.]com|skamason[.]com|sluppend[.]com|smeartha[.]com|sprysphere[.]com|stratoplot[.]com|streamvoyage[.]com|st[.]uploadit[.]host|svencrai[.]com|swarife[.]com|swiftation[.]com|swifttopia[.]com|thacorag[.]com|thouth[.]net|tinyical[.]com|tinyium[.]com|tonancos[.]com|toolusts[.]com|triabicia[.]com|turboagram[.]com|twineer[.]com|twiriock[.]com|urstoron[.]com|velocicosm[.]com|velociterium[.]com|viahold[.]com|vismuene[.]com|viwright[.]com|vonasort[.]com|whareotiv[.]com|wirecellar[.]com|www[.]adf[.]ly|www[.]cowner[.]net|xterca[.]net|yabuilder[.]com|yamechanic[.]com|yoalizer[.]com|yobuilder[.]com|yoineer[.]com|yoitect[.]com|zipansion[.]com|zipteria[.]com|zipvale[.]com|zo[.]ee|zoee[.]xyz)/.",
	//     "^https?://bit[.]ly/."
	// }
}

fn mainmode() ?string {
	mut status := http.get('https://api.bypass.vip/') ?
	mut asciiart := '$clear $cyan
	    ╔╗         ╔╗              ╔╗           
	    ║║         ║║             ╔╝╚╗          
	╔╗╔╗║║   ╔╗╔══╗║║╔╗╔╗╔╗╔══╗╔═╗╚╗╔╝╔╗╔══╗╔══╗
	║╚╝║║║ ╔╗╠╣║╔╗║║╚╝╝║╚╝║║╔╗║║╔╝ ║║ ╠╣║ ═╣║╔╗║
	╚╗╔╝║╚═╝║║║║║║║║╔╗╗╚╗╔╝║╚═╣║║  ║╚╗║║╠═ ║║╚═╣
	 ╚╝ ╚═══╝╚╝╚╝╚╝╚╝╚╝ ╚╝ ╚══╝╚╝  ╚═╝╚╝╚══╝╚══╝$reset
$blue	        𝙲𝚛𝚎𝚍𝚒𝚝𝚜 $magenta⤘$reset $blue 𝚐𝚒𝚝𝚑𝚞𝚋/𝟿𝚡𝙽'
	println(asciiart)
	if status.status_code == 200 {
		println('	        𝚂𝚝𝚊𝚝𝚞𝚜 $reset $magenta⤘$reset $blue 𝚘𝚗𝚕𝚒𝚗𝚎 $reset$green●$reset')
	} else {
		println('	        𝚂𝚝𝚊𝚝𝚞𝚜 $reset $magenta⤘$reset $blue 𝚘𝚏𝚏𝚕𝚒𝚗𝚎 $reset$red●$reset')
	}
	link := os.input_opt('$cyan Enter link to bypass $magenta⤘$reset $cyan') ?
	result := bypass(link) ?
	return result
}

fn fastmodefn(link string) {
	mut result := bypass(link) or { return }
	println(result)
}

fn apimodefn(port int) {
	vweb.run(&Api{}, port)
}

['/:link/plaintext']
fn (mut api Api) plaintext(link string) vweb.Result {
	result := bypass(link) or { return api.json({
		'error': '$err'
	}) }
	return api.json({
		'result': result
	})
}

fn (mut api Api) index() vweb.Result {
	return api.text('Api is online')
}

fn webserverfn(port int) {
	vweb.run(&Web{}, port)
}

pub fn (mut web Web) index() vweb.Result {
	return web.html('<h1>Webserver is online</h1>')
}

fn main() {
	mut args := os.args.clone()
	mut url := ''
	mut fastmode := false
	mut apimode := false
	mut webserver := false
	mut port := 0

	for i, arg in args {
		match arg {
			'-f' {
				url = args[i + 1]
				fastmode = true
			}
			'-s' {
				port = args[i + 1].int()
				apimode = true
			}
			'-w' {
				port = args[i + 1].int()
				webserver = true
			}
			else {}
		}
	}

	if fastmode == true {
		if url == '' {
			println('$red Link not specified $reset')
			return
		}
		// println("fastmode enabled")
		fastmodefn(url)
	}
	if apimode == true {
		// println("apimode enabled")
		apimodefn(port)
	}
	if webserver == true {
		// println("webserver enabled")
		webserverfn(port)
	}
	if fastmode == false && apimode == false && webserver == false {
		// println("mainmode enabled")
		for 0 == 0 {
			println(mainmode() ?)
			os.input('$cyan Press enter to continue...')
		}
	}
	if (apimode == true || webserver == true) && port == 0 {
		println('$red Port not specified $reset')
		return
	}
}

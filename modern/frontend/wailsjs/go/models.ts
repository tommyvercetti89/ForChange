export namespace main {
	
	export class FileInfo {
	    name: string;
	    size: number;
	    format: string;
	    path: string;
	
	    static createFrom(source: any = {}) {
	        return new FileInfo(source);
	    }
	
	    constructor(source: any = {}) {
	        if ('string' === typeof source) source = JSON.parse(source);
	        this.name = source["name"];
	        this.size = source["size"];
	        this.format = source["format"];
	        this.path = source["path"];
	    }
	}

}


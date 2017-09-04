let API = location.hostname === "127.0.0.1" ? "http://127.0.0.1:8081" : "https://api.devstat.thekev.in";
// let PROJECT = "5629499534213120";  // work
let PROJECT = "5668600916475904";  // personal

let nodes = new vis.DataSet([]);
let edges = new vis.DataSet([]);

let container = document.getElementById("network");
let data = {edges: edges, nodes: nodes};
let options = {};

let network = new vis.Network(container, data, options);

let get_color_for_status = (status) => {
    if (status == 1) {
        return "green";
    } else if (status == 2) {
        return "yellow";
    } else if (status == 3) {
        return "red";
    }

    return "#C0C0C0";
}

$.get(`${API}/link/${PROJECT}`, (resp) => {
    edges.update(resp.data.map((link) => ({
        arrows: "to",
        color: get_color_for_status(link.status),
        from: link.from,
        id: link.id,
        label: `${link.kind}:${link.name}`,
        to: link.to,
    })));
});

$.get(`${API}/project/${PROJECT}`, (resp) => {
    nodes.update(resp.data.map((project) => ({
        color: get_color_for_status(project.status),
        id: project.id,
        label: project.name,
        shape: "box",
    })));
});

$.get(`${API}/resource/${PROJECT}`, (resp) => {
    nodes.update(resp.data.map((resource) => ({
        color: get_color_for_status(resource.status),
        id: resource.id,
        label: `${resource.kind}:${resource.name}`,
        shape: "box",
    })));
});

$.get(`${API}/usage/${PROJECT}`, (resp) => {
    edges.update(resp.data.map((usage) => ({
        arrows: "to,from",
        color: get_color_for_status(usage.status),
        id: usage.id,
        from: usage.project,
        to: usage.resource,
    })));
});
